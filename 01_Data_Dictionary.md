# Godrej Riverine — Data Dictionary
**Project:** Godrej Riverine CRM, Marketing, Sales & Inventory Analytics
**Version:** 1.0
**Author:** Shreyansh
**Last Updated:** [fill in today's date]

> A data dictionary is the single source of truth for every field in your database.
> Anyone (including future-you, 6 months from now) should be able to open this file and
> understand exactly what each column means, what values it can hold, and how tables connect —
> without having to re-read the raw CSVs.

---

## 1. Customers
*Grain: one row per prospective/actual buyer.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Customer_ID | VARCHAR(10) — **PK** | Unique customer identifier | CUST00001 |
| First_Name | VARCHAR(50) | Customer's first name | Sarika |
| Last_Name | VARCHAR(50) | Customer's last name | Nagar |
| Gender | VARCHAR(10) | Male / Female | Female |
| Age | INT | Customer's age in years | 51 |
| Marital_Status | VARCHAR(15) | Married / Single | Married |
| Occupation | VARCHAR(50) | Job category (Business Owner, CXO, Doctor, etc.) | Business Owner |
| Company | VARCHAR(100) | Employer or business name | Self-Employed / Own Enterprise |
| Annual_Income | BIGINT | Yearly income in INR | 16625000 |
| Net_Worth | BIGINT | Estimated net worth in INR | 181030000 |
| City | VARCHAR(50) | NCR city of residence | Gurgaon |
| Current_Residence | VARCHAR(100) | Specific locality | Sohna Road, Gurgaon |
| Family_Size | INT | Number of family members | 3 |
| Existing_Home | VARCHAR(5) | Yes / No — owns a home already | Yes |
| Investment_Purpose | VARCHAR(30) | Self Use / Investment / Rental Income / etc. | Child's Future Home |
| Preferred_BHK | VARCHAR(10) | 3BHK / 4BHK / 5BHK | 4BHK |
| Budget | BIGINT | Max budget in INR | 82700000 |
| Preferred_Payment | VARCHAR(40) | Home Loan / Self-Funded / etc. | Self-Funded |
| Created_Date | DATE | Date customer record was created (= first lead touch) | 2024-05-20 |

---

## 2. Leads
*Grain: one row per inquiry/lead. A customer can generate multiple leads.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Lead_ID | VARCHAR(10) — **PK** | Unique lead identifier | LEAD00001 |
| Customer_ID | VARCHAR(10) — **FK → Customers** | Customer who raised this lead | CUST00001 |
| Lead_Date | DATE | Date the lead was captured | 2024-05-20 |
| Lead_Source | VARCHAR(30) | Channel the lead came from (Google Ads, Referral, Channel Partner, etc.) | Google Ads |
| Campaign_ID | VARCHAR(10) — **FK → Marketing_Campaigns** (nullable) | Campaign that generated this lead (only for paid channels) | CAMP047 |
| Project | VARCHAR(30) | Project name (constant) | Godrej Riverine |
| Lead_Status | VARCHAR(30) | Funnel stage: New / Contacted / Qualified / Site Visit Scheduled / Negotiation / Converted / Not Interested / Lost | Not Interested / Lost |
| Interest_Score | INT | 1–10 self/agent-rated interest level | 6 |
| Budget_Fit | VARCHAR(10) | Yes / Partial / No — does budget match unit price | Yes |
| Sales_Executive_ID | VARCHAR(10) — **FK → Sales_Executives** | Assigned sales rep | EXEC24 |

---

## 3. Site_Visits
*Grain: one row per physical site visit. Only leads that reach "Qualified" or beyond get a visit.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Visit_ID | VARCHAR(11) — **PK** | Unique visit identifier | VISIT00001 |
| Lead_ID | VARCHAR(10) — **FK → Leads** | Lead this visit belongs to | LEAD00005 |
| Visit_Date | DATE | Date of the site visit | 2025-05-12 |
| Sales_Executive_ID | VARCHAR(10) — **FK → Sales_Executives** | Executive who hosted the visit | EXEC12 |
| Visit_Rating | INT | 1–5 rating of visit quality/experience | 4 |
| Family_Attended | VARCHAR(5) | Yes / No — did family accompany | No |
| Sample_Flat | VARCHAR(10) | Configuration of sample flat shown | 4BHK |
| Visit_Duration | INT | Duration of visit in minutes | 83 |
| Booking_Probability | DECIMAL(4,2) | Model-estimated probability (0–1) of converting | 0.72 |

---

## 4. Follow_Ups
*Grain: one row per follow-up touchpoint (call/WhatsApp/email/etc.) on a lead.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| FollowUp_ID | VARCHAR(9) — **PK** | Unique follow-up identifier | FU000001 |
| Lead_ID | VARCHAR(10) — **FK → Leads** | Lead being followed up on | LEAD00001 |
| FollowUp_Date | DATE | Date of the touchpoint | 2024-06-10 |
| Mode | VARCHAR(30) | Call / WhatsApp / Email / Meeting / etc. | Site Visit Reminder |
| Purpose | VARCHAR(40) | Reason for the follow-up | Site Visit Invitation |
| Outcome | VARCHAR(30) | Result of the touchpoint | Not Interested |

---

## 5. Bookings
*Grain: one row per confirmed unit sale. Only Converted leads appear here.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Booking_ID | VARCHAR(9) — **PK** | Unique booking identifier | BOOK00001 |
| Lead_ID | VARCHAR(10) — **FK → Leads** (unique) | The converted lead | LEAD09734 |
| Booking_Date | DATE | Date of booking | 2024-01-28 |
| Tower | VARCHAR(2) | Tower code (A–H, sold-out phase) | B |
| Floor | INT | Floor number | 15 |
| Unit_No | VARCHAR(10) | Unique unit code | B1503 |
| Configuration | VARCHAR(10) | 3BHK / 4BHK / 5BHK | 4BHK |
| Sale_Value | BIGINT | Final sale price in INR | 99800000 |
| Discount | DECIMAL(4,2) | Discount % applied | 0.72 |
| Payment_Plan | VARCHAR(40) | Construction Linked / Down Payment / etc. | Possession Linked Plan |
| Booking_Status | VARCHAR(30) | Confirmed / Agreement Signed / Registered / Under Registration | Agreement Signed |

---

## 6. Inventory
*Grain: one row per unsold/available unit in the currently open tower phase (I–L).*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Tower | VARCHAR(2) | Tower code (I–L, current phase) | I |
| Floor | INT | Floor number | 1 |
| Unit_No | VARCHAR(10) — **PK** | Unique unit code | I0101 |
| Configuration | VARCHAR(10) | 3BHK / 4BHK / 5BHK | 4BHK |
| Facing | VARCHAR(30) | River View / Park View / City View / etc. | River View |
| Status | VARCHAR(15) | Available / Reserved / Booked | Available |

> **Note:** Inventory (Towers I–L) and Bookings (Towers A–H) intentionally represent two
> different phases of the same project — A–H is the sold-out launch phase, I–L is the
> currently-open phase. This mirrors how real developers report inventory: only *currently
> sellable* stock shows up in the live inventory sheet.

---

## 7. Sales_Executives
*Grain: one row per sales team member.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Executive_ID | VARCHAR(6) — **PK** | Unique executive identifier | EXEC01 |
| Executive_Name | VARCHAR(60) | Full name | Rohit Malhotra |
| Experience | INT | Years of industry experience | 8 |
| Manager | VARCHAR(60) | Reporting manager | Vikram Sehgal (Regional Manager - Delhi/Gurgaon) |
| Monthly_Target | BIGINT | Monthly sales revenue target in INR | 198300000 |
| Joining_Date | DATE | Date joined Godrej Properties | 2019-08-07 |

---

## 8. Marketing_Campaigns
*Grain: one row per marketing campaign.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Campaign_ID | VARCHAR(7) — **PK** | Unique campaign identifier | CAMP001 |
| Campaign_Name | VARCHAR(80) | Descriptive campaign name | Godrej Riverine - Lead Gen Carousel |
| Channel | VARCHAR(30) | Google Ads / Instagram / Facebook / LinkedIn / Metro Branding / Newspaper Insert | Facebook |
| Start_Date | DATE | Campaign start date | 2026-02-10 |
| End_Date | DATE | Campaign end date | 2026-04-26 |
| Objective | VARCHAR(30) | Lead Generation / Brand Awareness / etc. | Site Visit Drive |

---

## 9. Marketing_Spend
*Grain: one row per calendar month (36 rows = Jan 2024–Dec 2026).*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Month | VARCHAR(7) — **PK** | Year-Month (YYYY-MM) | 2024-01 |
| Google | BIGINT | Monthly spend on Google Ads (INR) | 4085000 |
| Meta | BIGINT | Monthly spend on Facebook + Instagram (INR) | 2283000 |
| LinkedIn | BIGINT | Monthly spend on LinkedIn (INR) | 0 |
| OOH | BIGINT | Out-of-home / billboard spend (INR) | 774000 |
| Metro | BIGINT | Metro branding spend (INR) | 1114000 |
| Print | BIGINT | Newspaper insert spend (INR) | 0 |
| Events | BIGINT | Sample flat launches/events spend (INR) | 513000 |
| ChannelPartners | BIGINT | Channel partner incentive payouts (INR) | 2338000 |

---

## 10. Channel_Partners
*Grain: one row per broker/channel partner.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Partner_ID | VARCHAR(6) — **PK** | Unique partner identifier | CP001 |
| Partner_Name | VARCHAR(60) | Broker/firm name | Suresh Solanki |
| Location | VARCHAR(60) | Office location | Preet Vihar, Delhi |
| Experience | INT | Years in real estate brokerage | 4 |
| Leads_Generated | INT | Total leads sourced by this partner | 6 |
| Bookings | INT | Total bookings closed via this partner | 0 |

---

## 11. Competitor_Analysis
*Grain: one row per mystery-shopper visit to a competitor project.*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Visit_ID | VARCHAR(12) — **PK** | Unique competitor-visit identifier | CVISIT00001 |
| Competitor | VARCHAR(30) | Prestige / Sobha Aurum / Mahagun Manorial | Sobha Aurum |
| Visit_Date | DATE | Date of the competitor visit | 2026-09-08 |
| Price_Score | DECIMAL(3,1) | 1–10 price/value perception score | 6.1 |
| Sales_Score | DECIMAL(3,1) | 1–10 sales team quality score | 7.9 |
| Amenities_Score | DECIMAL(3,1) | 1–10 amenities score | 9.0 |
| Trust_Score | DECIMAL(3,1) | 1–10 brand trust score | 8.0 |
| Overall_Rating | DECIMAL(3,1) | Weighted composite score | 8.3 |

---

## 12. Psychological_Survey
*Grain: one row per site-visit survey (1:1 with Site_Visits).*

| Column | Data Type | Description | Example |
|---|---|---|---|
| Survey_ID | VARCHAR(9) — **PK** | Unique survey identifier | SURV00001 |
| Lead_ID | VARCHAR(10) — **FK → Leads** | Lead who took the survey | LEAD00005 |
| Trust_Score | INT | 1–10 trust in the brand | 9 |
| FOMO_Score | INT | 1–10 fear-of-missing-out score | 5 |
| Luxury_Score | INT | 1–10 luxury preference score | 2 |
| Investment_Score | INT | 1–10 investment-orientation score | 5 |
| Price_Sensitivity | INT | 1–10 price sensitivity score | 5 |
| Transparency_Rating | INT | 1–10 perceived transparency of the company | 9 |
| Booking_Decision | VARCHAR(5) | Yes / No — did survey suggest a booking decision | Yes |

---

## Key Relationships Summary

| Parent Table | Child Table | Join Key |
|---|---|---|
| Customers | Leads | Customer_ID |
| Sales_Executives | Leads | Sales_Executive_ID |
| Marketing_Campaigns | Leads | Campaign_ID (nullable) |
| Leads | Site_Visits | Lead_ID |
| Sales_Executives | Site_Visits | Sales_Executive_ID |
| Leads | Follow_Ups | Lead_ID |
| Leads | Bookings | Lead_ID (1:1, only Converted leads) |
| Leads | Psychological_Survey | Lead_ID (1:1 with Site_Visits) |
| — | Inventory | standalone (no FK; separate open-phase tower stock) |
| — | Marketing_Spend | standalone (aggregated monthly, joins to Marketing_Campaigns loosely via month + channel) |
| — | Channel_Partners | standalone (aggregated summary; detail-level join would require partner-lead mapping, which isn't stored at row level) |
| — | Competitor_Analysis | standalone (no FK; external market research) |
