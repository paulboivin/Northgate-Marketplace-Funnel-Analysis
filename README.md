# Northgate-Marketplace-Funnel-Analysis
E-commerce funnel analysis identifying $217,956 in lost revenue from cart abandonment for a fictional company. SQL, Python, Power BI.

# Cart Abandonment and Revenue Recovery Analysis - Northgate Marketplace

## Executive Summary
Northgate Marketplace achieved an overall session-to-purchase conversion 
rate of 2.22% in 2024, while cart abandonment resulted in $217,956 in 
lost revenue, 1.82 times the $119,555 in revenue successfully captured,  
with 65% of all sessions originating from mobile devices. After identifying 
that the largest source of revenue loss stems from cart abandonment in the 
Electronics category, recommended interventions include targeted cart 
recovery tools, abandoned cart email reminders, and a mobile checkout 
experience redesign, which is projected to generate between $2,982 and $9,048 in 
additional annual revenue.

## Business Problem
Completed orders and a seamless customer experience are paramount to the 
success of Northgate Marketplace. Despite maintaining an overall conversion 
rate of 2.22%, lost revenue exceeds captured revenue by a factor of 1.82x, 
representing a significant and addressable gap in funnel performance. Sales 
stakeholders have requested an investigation into this discrepancy and 
potential solutions to address the gap.

## Dashboard
![Northgate Marketplace Funnel Dashboard](dashboard/dashboard_screenshot.png.png)

## Methodology
1. Generated a synthetic transactional dataset simulating 76,709 customer 
sessions across 2024 using Python, including products, sessions, events, 
and orders across a four-table relational schema.
2. Wrote SQL queries to analyze funnel conversion rates, cart abandonment 
by category and device type, monthly conversion trends, and revenue impact 
of funnel drop-off.
3. Built an interactive Power BI dashboard to visualize funnel performance, 
lost revenue by category, and monthly conversion trends with category 
filtering.
4. Created a Python revenue recovery simulation modeling the financial 
impact of reducing Electronics cart abandonment by 5%, 10%, and 15%.

## Skills
**SQL:** Relational database design, CTEs, window functions, anti-join 
pattern, funnel aggregation queries

**Power BI:** Data modeling with relationships, DAX measures, funnel chart, 
interactive slicer, dashboard design

**Python:** Synthetic data generation with realistic e-commerce benchmarks, 
revenue recovery simulation modeling

## Results
The dashboard enables sales stakeholders to independently access and filter 
funnel metrics by product category. The analysis identifies an 88.63% 
drop-off rate at the product view to add-to-cart stage as the primary 
funnel leak. Electronics accounts for 27.88% of total lost revenue at 
$60,764 annually, driven by high per-cart values averaging $102.82. 
Secondary categories of concern include Home and Kitchen and Sports and 
Outdoors. Mobile users consistently exhibit higher cart abandonment rates 
than desktop users across all categories, making mobile checkout 
optimization a priority intervention.

## Business Recommendation
The revenue recovery model projects that reducing Electronics cart 
abandonment by 5% to 15% would generate between $2,982 and $9,048 in 
additional annual revenue. Recommended actions for the Product, Marketing, 
and Revenue Operations teams:

1. Implement cart recovery tools for customers with active but inactive carts.
2. Create email and text reminders for customers with abandoned carts.
3. Redesign the mobile checkout experience to reduce friction and improve 
conversion for high-value Electronics purchases.

Prioritizing Electronics and mobile users targets the highest-value 
abandonment segment identified in the analysis.

## Next Steps
1. Establish A/B testing with mobile UI redesign.
2. Examine Home and Kitchen and Sports and Outdoors categories for similar 
abandonment patterns.
3. Measure email and text open rates to determine campaign effectiveness.

## Repository Structure

```bash
Northgate-Marketplace-Funnel-Analysis/
│
├── README.md
├── data/raw/
│   ├── products.csv
│   ├── sessions.csv
│   ├── events.csv
│   └── orders.csv
├── python/
│   ├── Northgate_Data_Generation.ipynb
│   └── Northgate_Analysis.ipynb
├── sql/
│   ├── northgate_marketplace.db
│   ├── 00_create_schema.sql
│   ├── 01_funnel_conversion.sql
│   ├── 02_cart_abandonment.sql
│   ├── 03_monthly_conversion_trend.sql
│   └── 04_revenue_impact.sql
├── dashboard/
│   ├── Northgate_Marketplace_Dashboard.pbix
│   └── dashboard_screenshot.png
└── insights/
└── Northgate_Cart_Abandonment_Analysis.docx

```

---

## How to Run
Requires Python with pandas and numpy, SQLite or related SQL programs 
for the SQL queries, and Power BI Desktop for the dashboard. All data 
files are in the data/raw folder.
