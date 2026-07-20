# Business Requirements Document (BRD)
**Project:** Godrej Riverine — CRM, Marketing & Sales Analytics
**Prepared by:** Shreyansh (Business Analyst / Data Analyst)
**Status:** ✅ Completed
**Date:** 20 July 2026

---

## 1. Background

Godrej Riverine is a luxury residential project in Sector 44, Noida, targeting upper-middle-class
and HNI buyers with 3/4/5 BHK units priced ₹7–12 Cr. The Sales, Marketing, and CRM teams
currently track leads, site visits, follow-ups, bookings, and marketing spend in disconnected
spreadsheets, making it difficult to answer basic questions quickly (e.g. "which channel gives us
the cheapest cost-per-booking?").

## 2. Business Problem

Leadership could not previously answer, on demand:
1. Which marketing channels/campaigns generate the highest-quality (highest-converting) leads?
2. Where in the sales funnel are we losing the most leads, and why?
3. Which sales executives and channel partners are top/bottom performers?
4. What does our current inventory position look like (by tower, floor, configuration, facing)?
5. How do we compare to key competitors (Prestige, Sobha Aurum, Mahagun Manorial)?
6. What psychological/behavioral factors (trust, FOMO, price sensitivity) actually predict a
   booking decision?

All six questions are now answerable directly from the Power BI dashboard — see
`07_Business_Insights.md` for the findings.

## 3. Objectives — Status

| Objective | Status |
|---|---|
| Build a single source of truth (SQL database) consolidating all 12 CRM/Marketing/Sales tables | ✅ Done — see `04_SQL_schema.sql` |
| Design a Power BI dashboard that lets stakeholders self-serve answers to the above questions | ✅ Done — see `06_Godrej_Riverine_Dashboard.pbix` |
| Quantify marketing ROI (spend → leads → visits → bookings) by channel and campaign | ✅ Done — Marketing Analysis page + `05_SQL_analysis_queries.sql` |
| Provide a sales funnel view with drop-off rates at every stage | ✅ Done — Lead & CRM Funnel page |
| Track sales executive and channel partner performance against targets | ✅ Done — Sales Performance page |
| Surface a live inventory position (available/reserved/booked, by tower/floor/facing) | ✅ Done — Inventory & Property page |

## 4. Stakeholders

| Stakeholder | Interest | Where addressed |
|---|---|---|
| Sales Head | Funnel performance, executive performance, booking trends | Sales Performance page |
| Marketing Head | Channel/campaign ROI, cost per lead, cost per booking | Marketing Analysis page |
| CRM/Ops Team | Lead status hygiene, follow-up cadence, data quality | Lead & CRM Funnel page |
| Leadership/CXO | High-level revenue, inventory position, competitive standing | Executive Summary + Inventory & Property pages |

## 5. Scope

**In scope (delivered):**
- Customers, Leads, Site_Visits, Follow_Ups, Bookings, Inventory, Sales_Executives,
  Marketing_Campaigns, Marketing_Spend, Channel_Partners, Competitor_Analysis,
  Psychological_Survey (all 12 tables, Jan 2024–Dec 2026).
- SQL data modeling, cleaning, and business-query layer.
- Power BI star-schema model and 5-page dashboard.

**Out of scope (unchanged):**
- Real-time/live data refresh (this is a static, point-in-time analytical project).
- Predictive modeling / machine learning (Booking_Probability and psychological scores are
  pre-computed fields available for exploration, not modeled here).
- Any data beyond Dec 2026 or outside the Godrej Riverine project.

## 6. Key Business Questions the Dashboard Answers

1. What is the lead-to-booking conversion rate, overall and by lead source? → Lead & CRM Funnel page
2. What is the drop-off rate at each funnel stage? → Lead & CRM Funnel page (funnel chart)
3. What is the cost per lead and cost per booking, by marketing channel? → Marketing Analysis page
4. Which sales executives are over/under their monthly targets? → Sales Performance page
5. Which channel partners generate the most leads and the highest conversion rate? → Sales Performance / Channel Partner table
6. What does current inventory look like by tower, configuration, and facing? → Inventory & Property page
7. How does Godrej Riverine's competitive positioning compare? → Inventory & Property page (Competitor table)
8. Which psychological factors most strongly relate to a booking decision? → `07_Business_Insights.md`, insight 10

## 7. Success Criteria — Final Status

- [x] All 12 tables loaded into MySQL with correct primary/foreign keys and referential integrity
- [x] A documented star schema in Power BI (fact tables + dimension tables) — see `02_Database_ERD.md`
- [x] A 5-page dashboard: Executive Summary, Sales Performance, Lead & CRM Funnel, Marketing Analysis, Inventory & Property
- [x] 10 written business insights following the "What happened → Why → Impact → Recommendation" format — see `07_Business_Insights.md`
- [x] A GitHub repository with README, screenshots, and full documentation

---

*This document was the planning reference for the project. All objectives listed have been delivered — see the repository README for a guided walkthrough of every deliverable.*
