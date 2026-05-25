-- Query 3: Monthly Funnel Conversion Rate Trend

-- This query tracks how the overall conversion rate has changed
-- month over month across the 2024 analytical period.

-- How has the overall funnel conversion rate trended month over month?

WITH monthly_funnel AS (
    -- Counts the sessions and purchases per month.
    SELECT
        strftime('%m', s.session_date)      AS month_num,
        CASE strftime('%m', s.session_date)
            WHEN '01' THEN 'January'
            WHEN '02' THEN 'February'
            WHEN '03' THEN 'March'
            WHEN '04' THEN 'April'
            WHEN '05' THEN 'May'
            WHEN '06' THEN 'June'
            WHEN '07' THEN 'July'
            WHEN '08' THEN 'August'
            WHEN '09' THEN 'September'
            WHEN '10' THEN 'October'
            WHEN '11' THEN 'November'
            WHEN '12' THEN 'December'
        END                                 AS month_name,
        COUNT(DISTINCT s.session_id)        AS total_sessions,
        COUNT(DISTINCT CASE WHEN e.event_type = 'purchase'
              THEN s.session_id END)        AS purchases,
        COUNT(DISTINCT CASE WHEN e.event_type = 'add_to_cart'
              THEN s.session_id END)        AS cart_additions
    FROM sessions s
    LEFT JOIN events e ON s.session_id = e.session_id
    GROUP BY month_num, month_name
),
monthly_with_lag AS (
    -- Adds previous month conversion rate for MoM comparison.
    SELECT
        month_num,
        month_name,
        total_sessions,
        purchases,
        cart_additions,
        ROUND(purchases * 100.0 / 
              total_sessions, 2)            AS conversion_rate_pct,
        ROUND(cart_additions * 100.0 / 
              total_sessions, 2)            AS cart_rate_pct,
        LAG(ROUND(purchases * 100.0 / 
            total_sessions, 2))
            OVER (ORDER BY month_num)       AS prev_month_conversion,
        LAG(total_sessions)
            OVER (ORDER BY month_num)       AS prev_month_sessions
    FROM monthly_funnel
)
SELECT
    month_num,
    month_name,
    total_sessions,
    purchases,
    cart_additions,
    conversion_rate_pct,
    cart_rate_pct,
    prev_month_conversion,
    -- This is the month over month change in conversion rate.
    ROUND(conversion_rate_pct - 
          prev_month_conversion, 2)         AS mom_conversion_change,
    -- This is the month over month change in session volume.
    ROUND((total_sessions - prev_month_sessions) 
          * 100.0 / prev_month_sessions, 2) AS mom_session_growth_pct
FROM monthly_with_lag
ORDER BY month_num;