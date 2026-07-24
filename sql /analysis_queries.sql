
-- GODREJ RIVERINE, NOIDA — BUSINESS INTELLIGENCE ANALYSIS QUERIES

USE godrej_riverine;

-- SECTION A: LEAD CONVERSION ANALYSIS
-- 
-- A1. Conversion rate by Lead_Source (simple JOIN + aggregation)
-- Business question: which channel brings leads that actually book?
-- 
SELECT
    l.Lead_Source,
    COUNT(DISTINCT l.Lead_ID)                              AS total_leads,
    COUNT(DISTINCT b.Booking_ID)                           AS total_bookings,
    ROUND(COUNT(DISTINCT b.Booking_ID) * 100.0
          / COUNT(DISTINCT l.Lead_ID), 2)                  AS conversion_rate_pct
FROM Leads l
LEFT JOIN Bookings b ON l.Lead_ID = b.Lead_ID
GROUP BY l.Lead_Source
ORDER BY conversion_rate_pct DESC;

-- 
-- A2. Full funnel drop-off: Lead -> Site Visit -> Follow-Up -> Booking
-- (chained CTEs, one per funnel stage)
-- Business question: at which stage are we losing the most leads?
-- 
WITH visited AS (
    SELECT DISTINCT Lead_ID FROM Site_Visits
),
followed_up AS (
    SELECT DISTINCT Lead_ID FROM Follow_Ups
),
booked AS (
    SELECT DISTINCT Lead_ID FROM Bookings
)
SELECT
    l.Lead_Source,
    COUNT(DISTINCT l.Lead_ID)                                        AS stage_1_leads,
    COUNT(DISTINCT v.Lead_ID)                                        AS stage_2_site_visits,
    COUNT(DISTINCT f.Lead_ID)                                        AS stage_3_followed_up,
    COUNT(DISTINCT bk.Lead_ID)                                       AS stage_4_booked,
    ROUND(COUNT(DISTINCT bk.Lead_ID) * 100.0 / COUNT(DISTINCT l.Lead_ID), 2) AS conversion_pct
FROM Leads l
LEFT JOIN visited v     ON l.Lead_ID = v.Lead_ID
LEFT JOIN followed_up f ON l.Lead_ID = f.Lead_ID
LEFT JOIN booked bk     ON l.Lead_ID = bk.Lead_ID
GROUP BY l.Lead_Source
ORDER BY conversion_pct DESC;

--
-- A3. Sales Executive performance ranking (CTE + RANK window function)
-- Business question: who are the top-performing execs by revenue closed?
-- 
WITH exec_perf AS (
    SELECT
        se.Executive_ID,
        se.Executive_Name,
        COUNT(DISTINCT l.Lead_ID)              AS leads_handled,
        COUNT(DISTINCT b.Booking_ID)           AS bookings_closed,
        COALESCE(SUM(b.Sale_Value), 0)         AS total_sales_value
    FROM Sales_Executives se
    LEFT JOIN Leads l    ON se.Executive_ID = l.Sales_Executive_ID
    LEFT JOIN Bookings b ON l.Lead_ID = b.Lead_ID
    GROUP BY se.Executive_ID, se.Executive_Name
)
SELECT
    Executive_Name,
    leads_handled,
    bookings_closed,
    total_sales_value,
    ROUND(bookings_closed * 100.0 / NULLIF(leads_handled, 0), 2) AS conversion_rate_pct,
    RANK() OVER (ORDER BY total_sales_value DESC)                AS sales_rank
FROM exec_perf
ORDER BY sales_rank;

-- 
-- A4. Average days from Lead creation to Booking, by source
-- Business question: which channel converts fastest?
-- 
SELECT
    l.Lead_Source,
    ROUND(AVG(DATEDIFF(b.Booking_Date, l.Lead_Date)), 1) AS avg_days_to_convert
FROM Leads l
JOIN Bookings b ON l.Lead_ID = b.Lead_ID
GROUP BY l.Lead_Source
ORDER BY avg_days_to_convert ASC;

-- 
-- SECTION B: SALES TREND ANALYSIS
-- 

-- 
-- B1. Monthly sales trend — running total + month-over-month growth
-- (CTE + window functions: SUM() OVER, LAG())
-- Business question: is revenue growing month over month, and by how much?
-- 
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(Booking_Date, '%Y-%m') AS sales_month,
        COUNT(*)                           AS units_sold,
        SUM(Sale_Value)                    AS monthly_revenue
    FROM Bookings
    GROUP BY DATE_FORMAT(Booking_Date, '%Y-%m')
)
SELECT
    sales_month,
    units_sold,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY sales_month) AS running_total_revenue,
    ROUND(
        (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY sales_month))
        * 100.0 / NULLIF(LAG(monthly_revenue) OVER (ORDER BY sales_month), 0)
    , 2)                                              AS mom_growth_pct
FROM monthly_sales
ORDER BY sales_month;

-- 
-- B2. Best-selling configuration (3BHK/4BHK/5BHK) per quarter
-- (CTE + ROW_NUMBER window function)
-- Business question: which unit type sells best, and does that shift quarter to quarter?
-- 
WITH quarterly_config_sales AS (
    SELECT
        CONCAT(YEAR(Booking_Date), '-Q', QUARTER(Booking_Date)) AS sales_quarter,
        Configuration,
        COUNT(*)          AS units_sold,
        SUM(Sale_Value)   AS revenue
    FROM Bookings
    GROUP BY sales_quarter, Configuration
),
ranked AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY sales_quarter ORDER BY revenue DESC) AS rn
    FROM quarterly_config_sales
)
SELECT sales_quarter, Configuration, units_sold, revenue
FROM ranked
WHERE rn = 1
ORDER BY sales_quarter;

-- 
-- B3. Channel Partner contribution to bookings (% share via window SUM)
-- Business question: which brokers/partners drive the most bookings?
-- 
SELECT
    Partner_Name,
    Leads_Generated,
    Bookings,
    ROUND(Bookings * 100.0 / SUM(Bookings) OVER (), 2) AS pct_of_total_bookings
FROM Channel_Partners
ORDER BY Bookings DESC;

-- 
-- B4. Marketing spend by channel vs leads generated (cost per lead)
-- (CTE that unpivots the wide Marketing_Spend table, then JOINs to Leads
--  via Marketing_Campaigns.Channel — the loose channel-level join noted
--  in the data dictionary, since Marketing_Spend has no Campaign_ID)
-- Business question: which marketing channel is most cost-efficient per lead?
-- 
WITH spend_by_channel AS (
    SELECT 'Google'          AS Channel, SUM(Google)          AS total_spend FROM Marketing_Spend
    UNION ALL SELECT 'Meta',            SUM(Meta)             FROM Marketing_Spend
    UNION ALL SELECT 'LinkedIn',        SUM(LinkedIn)         FROM Marketing_Spend
    UNION ALL SELECT 'OOH',             SUM(OOH)              FROM Marketing_Spend
    UNION ALL SELECT 'Metro',           SUM(Metro)            FROM Marketing_Spend
    UNION ALL SELECT 'Print',           SUM(Print)            FROM Marketing_Spend
    UNION ALL SELECT 'Events',          SUM(Events)           FROM Marketing_Spend
    UNION ALL SELECT 'ChannelPartners', SUM(ChannelPartners)  FROM Marketing_Spend
),
leads_by_channel AS (
    SELECT mc.Channel, COUNT(l.Lead_ID) AS leads_count
    FROM Leads l
    JOIN Marketing_Campaigns mc ON l.Campaign_ID = mc.Campaign_ID
    GROUP BY mc.Channel
)
SELECT
    sc.Channel,
    sc.total_spend,
    COALESCE(lc.leads_count, 0)                             AS leads_generated,
    ROUND(sc.total_spend / NULLIF(lc.leads_count, 0), 2)    AS cost_per_lead
FROM spend_by_channel sc
LEFT JOIN leads_by_channel lc ON sc.Channel = lc.Channel
ORDER BY sc.total_spend DESC;
