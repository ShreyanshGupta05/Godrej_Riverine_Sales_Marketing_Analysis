# Business Requirements Document (BRD)
**Project:** Godrej Riverine — CRM, Marketing & Sales Analytics

---

## 1. Background

Godrej Riverine is a luxury residential project in Sector 44, Noida, targeting upper-middle-class
and HNI buyers with 3/4/5 BHK units priced ₹7–12 Cr. The Sales, Marketing, and CRM teams
currently track leads, site visits, follow-ups, bookings, and marketing spend in disconnected
spreadsheets, making it difficult to answer basic questions quickly (e.g. "which channel gives us
the cheapest cost-per-booking?").

## 2. Business Problem

Leadership cannot currently answer, on demand:
1. Which marketing channels/campaigns generate the highest-quality (highest-converting) leads?
2. Where in the sales funnel are we losing the most leads, and why?
3. Which sales executives and channel partners are top/bottom performers?
4. What does our current inventory position look like (by tower, floor, configuration, facing)?
5. How do we compare to key competitors (Prestige, Sobha Aurum, Mahagun Manorial)?
6. What psychological/behavioral factors (trust, FOMO, price sensitivity) actually predict a
   booking decision?

## 3. Objectives

- Build a single source of truth (SQL database) consolidating all 12 CRM/Marketing/Sales tables.
- Design a Power BI dashboard that lets stakeholders self-serve answers to the above questions.
- Quantify marketing ROI (spend → leads → visits → bookings) by channel and campaign.
- Provide a sales funnel view with drop-off rates at every stage.
- Track sales executive and channel partner performance against targets.
- Surface a live inventory position (available/reserved/booked, by tower/floor/facing).

## 4. Stakeholders

| Stakeholder | Interest |
|---|---|
| Sales Head | Funnel performance, executive performance, booking trends |
| Marketing Head | Channel/campaign ROI, cost per lead, cost per booking |
| CRM/Ops Team | Lead status hygiene, follow-up cadence, data quality |
| Leadership/CXO | High-level revenue, inventory position, competitive standing |

## 5. Scope

**In scope:**
- Customers, Leads, Site_Visits, Follow_Ups, Bookings, Inventory, Sales_Executives,
  Marketing_Campaigns, Marketing_Spend, Channel_Partners, Competitor_Analysis,
  Psychological_Survey (all 12 tables, Jan 2024–Dec 2026).
- SQL data modeling, cleaning, and business-query layer.
- Power BI star-schema model and dashboard.

**Out of scope:**
- Real-time/live data refresh (this is a static, point-in-time analytical project).
- Predictive modeling / machine learning (though Booking_Probability and psychological scores
  are pre-computed fields available for exploration).
- Any data beyond Dec 2026 or outside the Godrej Riverine project.

## 6. Key Business Questions the Dashboard Must Answer

1. What is the lead-to-booking conversion rate, overall and by lead source?
2. What is the drop-off rate at each funnel stage (New → Contacted → Qualified → Site Visit →
   Negotiation → Converted)?
3. What is the cost per lead and cost per booking, by marketing channel?
4. Which sales executives are over/under their monthly targets?
5. Which channel partners generate the most leads and the highest conversion rate?
6. What does current inventory look like by tower, configuration, and facing?
7. How does Godrej Riverine's competitive positioning compare on price, sales experience,
   amenities, and trust?
8. Which psychological factors (trust, FOMO, price sensitivity) most strongly relate to a
   booking decision?

## 7. Success Criteria

- All 12 tables loaded into MySQL with correct primary/foreign keys and referential integrity.
- A documented star schema in Power BI (fact tables + dimension tables).
- A dashboard with at least 4 pages: Sales Funnel, Marketing ROI, Sales Team Performance,
  Inventory & Competitive Positioning.
- At least 10 written business insights following the "What happened → Why → Impact →
  Recommendation" format (Phase 5).
- A GitHub repository with README, screenshots, and this documentation (Phase 6).
