# Business Insights — Godrej Riverine CRM, Marketing & Sales Analytics

**Prepared by:** Shreyansh
**Format:** Each insight follows *What happened → Why it happened → Business Impact → Recommendation*, the way a Business Analyst would present findings to leadership.
**Source:** Numbers below are pulled directly from the live Power BI dashboard (Executive Summary, Sales Performance, Lead & CRM Funnel, Marketing Analysis, Inventory & Property pages) unless marked otherwise.

> ⚠️ Two data-quality items to fix before presenting this dashboard: (1) the Executive Summary page's per-executive table shows values ~1000x smaller than the Sales Performance page's chart for the same executives — likely a scoping or formatting bug, fix before relying on Page 1's table; (2) the funnel chart's stage labels are currently out of numeric order ("3. Followed Up" displaying before "2. Site Visits") — fix the visual's sort field. Insights below use Page 2 and the funnel's percentage figures, which are internally consistent.

---

### 1. Your two highest-volume lead sources are not your best-converting ones
**What happened:** Google Ads (1,894 leads) and Google Search (1,866 leads) generate by far the most volume, but convert at roughly 7.0–7.8% — near the bottom of all sources. Newspaper Insert generates the fewest leads (453) but converts at the highest rate of any source, close to 10%.
**Why it happened:** High-volume digital channels capture broad, lower-intent browsing traffic, while a print-insert reader who follows up is typically a deliberate, higher-intent enquiry.
**Business impact:** The channels absorbing the most marketing attention and spend are not the channels producing the highest-converting leads — volume and quality are moving in opposite directions.
**Recommendation:** Keep Google Ads/Search for top-of-funnel volume, but judge them on cost-per-lead, not conversion rate. Give smaller high-converting channels like Newspaper Insert more budget room to scale.
*[Source: Executive Summary — Total Leads by Source; Lead & CRM Funnel — Conversion Rate by Lead_Source]*

---

### 2. The real bottleneck is after the site visit, not before it
**What happened:** 60% of leads receive a site visit (matches the Lead to Visit Rate KPI exactly). But of roughly 9,000 site visits, only about 1,200 become bookings — an ~87% drop-off after the visit, compared to a 40% drop-off before it.
**Why it happened:** Getting someone to visit is largely a marketing/scheduling outcome; getting them to sign is a sales execution outcome — pricing conversations, negotiation follow-through, and closing discipline all happen after the visit.
**Business impact:** The single biggest leak in the funnel sits on the sales team's side, after marketing has already done its job — meaning more marketing spend will not fix this bottleneck.
**Recommendation:** Invest in post-visit sales process (structured objection handling, faster follow-up SLAs after a visit, negotiation training) rather than additional top-of-funnel lead generation.
*[Source: Lead & CRM Funnel — funnel chart stage percentages]*

---

### 3. Sales executive performance is fairly evenly distributed, not concentrated in a few hands
**What happened:** Across roughly 26 executives, total sales value ranges narrowly from ₹4.7bn (top performer, Poonam Thakur) to ₹2.9bn (bottom of the list) — about a 1.6x spread, not a small handful of stars carrying the team.
**Why it happened:** Likely a mix of consistent lead-assignment practices and a similarly-tenured sales team, rather than one or two people dominating.
**Business impact:** This is a low-risk finding — the business isn't overly dependent on any single executive, which limits key-person risk if a top performer leaves.
**Recommendation:** Rather than framing this as "fixing underperformers," focus coaching on closing the ~1.6x gap across the whole team, and investigate what the top 3-4 executives do differently specifically in the post-visit stage (ties directly to Insight 2).
*[Source: Sales Performance — Total Sales Value by Executive chart]*

---

### 4. Sales velocity by lead source — pending verification
**Status:** Not yet confirmed against the dashboard. Before including this as a numbered finding, pull `Avg Days to Convert` (SQL query A4, or add it as a Card visual filtered by Lead_Source) and replace this placeholder with the real numbers.
**Planned framing once verified:** Which lead sources convert fastest vs. slowest from Lead_Date to Booking_Date, and what that implies for revenue forecasting and sales capacity prioritization.

---

### 5. Available inventory configuration mix skews heavily toward 3BHK
**What happened:** Of currently available/remaining inventory, 3BHK accounts for 50% (208 units), 4BHK 43% (180 units), and 5BHK just 7% (28 units).
**Why it happened:** Either genuine buyer preference concentrates around 3BHK at this price point, or 5BHK was simply built/released in smaller supply from the start — this chart alone can't distinguish between a demand signal and a supply constraint.
**Business impact:** If 3BHK demand continues at this pace while supply is proportionally similar, absorption should stay balanced; if 5BHK is undersupplied relative to real demand, it may be selling out disproportionately fast without this being visible in a simple mix chart.
**Recommendation:** Cross-check this configuration mix against original launch inventory counts (not just what's currently remaining) to determine whether 5BHK's small remaining share reflects strong sell-through or limited supply from day one.
*[Source: Inventory & Property — Configuration Mix donut chart]*

---

### 6. Meta is likely your most cost-efficient major channel — but the current chart understates it
**What happened:** Computed cost-per-lead by channel: LinkedIn ~₹60K (cheapest, but only 769 leads), Meta combined (Facebook + Instagram, 2,723 leads total) ~₹1.35L, Google Ads ~₹1.83L, Newspaper Insert ~₹1.88L, Metro Branding ~₹2.56L (most expensive of the major channels).
**Why it happened:** Meta's total spend (₹367M) covers both Facebook and Instagram together in the source data — the current scatter chart splits that same spend and divides it separately against each platform's leads, which double-counts the same rupees against two lead pools and makes both platforms look individually more expensive than they actually are.
**Business impact:** Viewed correctly as one combined channel, Meta outperforms Google Ads on cost efficiency — a materially different conclusion than what the current chart shows at a glance.
**Recommendation:** Rebuild the scatter chart to plot "Meta (FB+IG combined)" as a single point rather than two separate ones, since spend cannot actually be split between the two platforms at the row level in this dataset — then re-evaluate channel budget allocation using the corrected number.
*[Source: Marketing Analysis — Total Spend by Channel + Cost per Lead vs Leads scatter chart]*

---

### 7. More than half of all leads aren't tied to any tracked marketing campaign
**What happened:** Of 15,000 total leads, only 6,381 (43%) came through channels with an associated Marketing_Campaigns record (Google Ads, Instagram, Facebook, LinkedIn, Metro Branding, Newspaper Insert). The remaining 8,619 leads (57%) came from Referral, Channel Partner, Google Search, MagicBricks, Housing.com, Walk-In, and 99acres — sources with no attributed campaign spend.
**Why it happened:** Organic search, property listing portals, referrals, and walk-ins are real, active acquisition channels — they're simply not run as budgeted "campaigns" the way paid social/search ads are.
**Business impact:** More than half of total pipeline volume is currently invisible to marketing ROI reporting, meaning cost-per-lead conversations only account for 43% of actual lead flow.
**Recommendation:** Track the 57% non-campaign share as its own reporting category with its own KPIs (lead volume, conversion rate, velocity) even without a spend figure to calculate ROI against — it's too large a share of the business to leave unmeasured.
*[Source: Executive Summary — Total Leads by Source, cross-referenced against Marketing_Campaigns channel list]*

---

### 8. Tower L is absorbing meaningfully faster than Tower I
**What happened:** Tower L is 45.2% booked (47 of 104 units), while Tower I lags at 33.7% booked (35 of 104) — an 11.5 percentage point gap despite identical total unit counts across both towers.
**Why it happened:** Facing (River View vs. City View), floor mix, or launch timing likely explain the tower-level gap more than a genuine difference in buyer demand.
**Business impact:** Tower I is tying up capital longer than the other three towers, which affects cash flow timing if left unaddressed.
**Recommendation:** Apply targeted incentives (loyalty pricing, flexible payment plans) specifically to Tower I rather than a uniform project-wide discount, and cross-check Facing/Floor data to confirm the actual driver before designing the incentive.
*[Source: Inventory & Property — Tower vs. Status stacked bar chart and matrix]*

---

### 9. Among competitors, Prestige leads on trust and sales experience — not on price
**What happened:** Prestige has the highest overall rating (7.61), driven by the strongest Sales_Score (8.02) and Trust_Score (8.40), despite having the lowest Price_Score (5.72) of the three tracked competitors. Mahagun Manorial has the best Price_Score (7.64) but the lowest overall rating (6.51), pulled down by weak Sales (5.93) and Trust (6.25) scores. Sobha Aurum leads specifically on Amenities (8.49).
**Why it happened:** Buyers appear to weight trust and sales experience more heavily than price perception when forming an overall impression of a project — price advantage alone isn't winning the market for Mahagun.
**Business impact:** This table currently only compares the three competitors against each other — it does not yet include a Godrej Riverine row, so it cannot answer "how do we compare," only "which lever matters most among competitors."
**Recommendation:** Add a Godrej Riverine row using the same scoring rubric (even a manually estimated one, sourced from internal survey or sales team input) so this table can directly answer competitive positioning — as it stands, present this insight as being about what drives competitor reputation, not about Godrej's own standing.
*[Source: Inventory & Property — Competitor Analysis table]*

---

### 10. Psychological factors vs. booking decision — pending verification
**Status:** Not yet confirmed against the dashboard; `Psychological_Survey` data wasn't part of any of the 5 built pages. Before including this as a numbered finding, run:
```DAX
Avg Trust Score - Booked = 
CALCULATE(AVERAGE(Psychological_Survey[Trust_Score]), Psychological_Survey[Booking_Decision] = "Yes")

Avg Trust Score - Not Booked = 
CALCULATE(AVERAGE(Psychological_Survey[Trust_Score]), Psychological_Survey[Booking_Decision] = "No")
```
Repeat for `Price_Sensitivity`, then write this insight to match whatever the real comparison shows — don't publish a claim the data hasn't actually confirmed.
**Planned framing once verified:** Which psychological factors (trust, FOMO, price sensitivity) most differ between leads who booked and those who didn't, and what that implies for sales conversation strategy.

---

## Before publishing this file
- [ ] Fix the Page 1 executive table scaling/formatting bug
- [ ] Fix the funnel chart's stage sort order
- [ ] Verify Insight 4 (avg days-to-convert by source) and rewrite with real numbers
- [ ] Verify Insight 10 (trust/price-sensitivity vs. booking decision) and rewrite with real numbers
- [ ] Rebuild the Meta scatter chart as one combined point (Insight 6) before showing it live in an interview, since the current version visually contradicts the corrected insight text

## How to present these in an interview
Pick 2-3 to walk through live if asked "tell me about an insight from this project." Insight 2 (post-visit bottleneck) and Insight 6 (Meta double-counting catch) are the strongest choices — the first shows real business reasoning, the second shows you can catch and correct a measurement error in your own analysis, which is exactly the kind of rigor interviewers are trying to probe for.
