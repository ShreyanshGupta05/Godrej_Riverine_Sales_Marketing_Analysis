# Business Insights — Godrej Riverine CRM, Marketing & Sales Analytics

**Prepared by:** Shreyansh
**Format:** Each insight follows *What happened → Why it happened → Business Impact → Recommendation*, the way a Business Analyst would present findings to leadership.

> Note: Replace the illustrative numbers below with your own dashboard's actual figures before publishing — pull each one directly from the corresponding Power BI page/visual referenced in brackets.

---

### 1. Lead-to-booking conversion varies sharply by source
**What happened:** Referral and Channel Partner leads convert at a meaningfully higher rate than paid digital leads (e.g. Google Ads, Meta), despite paid channels generating far higher lead *volume*.
**Why it happened:** Referral leads arrive pre-qualified — someone they trust has already vouched for the project — while paid ad clicks often come from lower-intent browsing.
**Business impact:** A large share of marketing spend is going toward high-volume, lower-quality leads, inflating cost per booking even when cost per lead looks cheap.
**Recommendation:** Shift a portion of budget from pure lead-volume campaigns toward referral incentive programs and channel partner empanelment, while keeping paid channels for top-of-funnel awareness rather than expecting them to convert at the same rate.
*[Source: Lead & CRM Funnel page — conversion-by-source chart]*

---

### 2. The funnel's biggest drop-off is between Site Visit and Follow-Up, not Lead and Visit
**What happened:** Most leads that get a site visit scheduled do show up, but a large proportion never receive a timely follow-up afterward.
**Why it happened:** Sales executives are focused on booking new site visits rather than nurturing recently-visited leads — follow-up cadence isn't systematically enforced.
**Business impact:** Genuinely warm leads (someone who already visited the property) are going cold due to process gaps, not lack of interest — this is the most preventable kind of lost revenue.
**Recommendation:** Introduce a mandatory follow-up SLA (e.g. within 48 hours of a site visit) and track compliance as a CRM hygiene KPI on the funnel page.
*[Source: Lead & CRM Funnel page — funnel chart, Stage 2→3 drop-off]*

---

### 3. A small number of sales executives drive a disproportionate share of revenue
**What happened:** The top 20% of sales executives (by the ranking table) are closing a much larger share of total booking value than the remaining executives.
**Why it happened:** Likely a mix of experience level, lead quality assigned to them, and individual follow-up discipline — not something the dashboard alone proves causally, but worth investigating.
**Business impact:** Over-reliance on a few high performers is a retention risk — if a top exec leaves, a large chunk of pipeline capability leaves with them.
**Recommendation:** Pair lower-performing executives with top performers for shadowing/mentoring, and review whether lead assignment is unintentionally favoring certain execs.
*[Source: Sales Performance page — Executive ranking table]*

---

### 4. Sales velocity differs meaningfully by lead source
**What happened:** Some lead sources convert to a booking noticeably faster (fewer average days from lead creation to booking) than others.
**Why it happened:** Faster-converting sources likely bring higher-intent buyers (e.g. someone actively searching vs. someone retargeted by an ad) who need less persuasion.
**Business impact:** Cash flow and revenue forecasting can be more accurate if the sales team knows which channels convert quickly vs. slowly, instead of treating all pipeline as equally time-to-close.
**Recommendation:** Use average days-to-convert by source as an input to revenue forecasting, and prioritize faster-converting-source leads when sales capacity is constrained.
*[Source: Sales Performance page / SQL query A4]*

---

### 5. 3BHK units dominate sales, but the mix shifts across quarters
**What happened:** 3BHK is consistently the best-selling configuration by both unit count and revenue, but 4BHK share increases in certain quarters.
**Why it happened:** Likely tied to seasonal marketing campaigns (e.g. HNI-targeted campaigns coinciding with a quarter) or inventory availability shifting which configurations are actively being sold.
**Business impact:** Inventory planning and marketing messaging that assumes a static configuration preference could misallocate effort in quarters where buyer preference actually shifts.
**Recommendation:** Align marketing campaign themes and sample flat availability with the configuration that historically sells best in the upcoming quarter, rather than a one-size-fits-all approach.
*[Source: Sales Performance page — Configuration by quarter chart]*

---

### 6. Marketing channels show very different cost-per-lead efficiency
**What happened:** Some channels (e.g. Meta/Facebook+Instagram) generate leads at a noticeably lower cost per lead than others (e.g. LinkedIn or Print), despite similar or higher total spend on the more expensive channels.
**Why it happened:** Channel-audience fit differs — LinkedIn's professional audience may not translate as efficiently to a luxury residential buyer pool as targeted social platforms with broader reach.
**Business impact:** Continuing to fund inefficient channels at the same level as efficient ones is a direct, quantifiable waste of marketing budget.
**Recommendation:** Reallocate a portion of underperforming channel budget toward the most cost-efficient channels, while monitoring for diminishing returns as spend concentration increases.
*[Source: Marketing Analysis page — Cost Per Lead by Channel scatter chart]*

---

### 7. A meaningful share of leads come from outside any tracked campaign
**What happened:** A notable portion of total leads have no associated marketing campaign at all (organic/referral/walk-in/direct).
**Why it happened:** These are leads that didn't originate from a paid or trackable channel — word of mouth, direct enquiry, or walk-ins at the sales office.
**Business impact:** This is a "hidden" acquisition channel that isn't currently measured or nurtured deliberately, yet may be some of the highest-intent, lowest-cost pipeline the business has.
**Recommendation:** Formally track and nurture the organic/referral channel as its own category rather than letting it go unmanaged just because it isn't tied to ad spend.
*[Source: Marketing Analysis page — blank/organic category noted during scatter chart build]*

---

### 8. Inventory absorption is uneven across towers
**What happened:** Some towers are absorbing (selling through) faster than others, despite similar total unit counts.
**Why it happened:** Facing (River View vs. City View), floor level, or timing of tower launch likely explain the gap more than raw demand differences.
**Business impact:** Slow-moving towers tie up capital longer and may eventually require pricing or incentive adjustments to clear remaining stock.
**Recommendation:** Apply targeted promotions (loyalty discounts, flexible payment plans) specifically to slower-absorbing towers rather than uniform discounting across all inventory.
*[Source: Inventory & Property page — Tower vs. Status stacked bar chart]*

---

### 9. Competitor benchmarking shows Godrej Riverine is not the market leader on every dimension
**What happened:** Comparing Overall_Rating across Prestige, Sobha Aurum, and Mahagun Manorial shows Godrej Riverine (implied by internal positioning, if included as a benchmark row) leads on trust/brand but may lag on price perception versus at least one competitor.
**Why it happened:** Premium brand positioning naturally trades off against price competitiveness — this is a strategic choice, not a flaw, but it should be a conscious one.
**Business impact:** If price sensitivity is a strong booking-decision factor (see insight 10) and competitors are perceived as better value, Godrej Riverine risks losing price-sensitive buyers even with strong brand trust.
**Recommendation:** Lean into brand trust and amenities in marketing messaging rather than competing head-on with competitors on price — play to the demonstrated strength rather than the weakness.
*[Source: Inventory & Property page — Competitor Analysis table]*

---

### 10. Trust and price sensitivity are the psychological factors most associated with booking decisions
**What happened:** Leads who ultimately booked tend to show higher `Trust_Score` and more moderate (not extreme) `Price_Sensitivity` in the psychological survey data, compared to leads who didn't book.
**Why it happened:** Trust reduces perceived risk in a large, long-term purchase; buyers who are extremely price-sensitive may be shopping primarily on discounts and are harder to close without heavy incentives.
**Business impact:** Sales conversations that build trust (site visit quality, transparent pricing, credible timelines) likely move the needle more than aggressive discounting for the median buyer.
**Recommendation:** Train sales executives to prioritize trust-building (transparency, third-party validation, clear possession timelines) over leading with discount offers, and reserve discount flexibility for genuinely high price-sensitivity segments only.
*[Source: Psychological_Survey table — cross-reference Trust_Score/Price_Sensitivity against Booking_Decision]*

---

## How to present these in an interview

Pick **2-3 of these** to walk through live if asked "tell me about an insight from this project" — don't try to recite all 10. For each one you choose, be ready to say the number out loud (not just "it converts better"), point to the exact dashboard visual it came from, and state the recommendation crisply in one sentence. That structure — number, visual, recommendation — is what makes an insight sound like real BA work rather than a vague observation.
