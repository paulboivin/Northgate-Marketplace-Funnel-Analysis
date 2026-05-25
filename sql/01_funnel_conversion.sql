-- Query 1: Overall Funnel Conversion Rate and Stage Drop-off

-- This query measures how many sessions progress through each
-- funnel stage and in which one does the largest drop-offs occur.

-- What is the overall end-to-end conversion
-- rate and drop-off rate at each individual funnel stage?

WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE WHEN event_type = 'session_start'
              THEN session_id END) AS sessions,
        COUNT(DISTINCT CASE WHEN event_type = 'product_view'
              THEN session_id END) AS product_views,
        COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart'
              THEN session_id END) AS cart_additions,
        COUNT(DISTINCT CASE WHEN event_type = 'checkout'
              THEN session_id END) AS checkouts,
        COUNT(DISTINCT CASE WHEN event_type = 'purchase'
              THEN session_id END) AS purchases
    FROM events
)
SELECT
    sessions                    AS total_sessions,
    product_views               AS reached_product_view,
    cart_additions              AS reached_add_to_cart,
    checkouts                   AS reached_checkout,
    purchases                   AS reached_purchase,
    ROUND(product_views * 100.0 / sessions, 2)
        AS pct_sessions_to_view,
    ROUND(cart_additions * 100.0 / sessions, 2)
        AS pct_sessions_to_cart,
    ROUND(checkouts * 100.0 / sessions, 2)
        AS pct_sessions_to_checkout,
    ROUND(purchases * 100.0 / sessions, 2)
        AS pct_sessions_to_purchase,
    ROUND((sessions - product_views) * 100.0 /
          sessions, 2)           AS dropoff_session_to_view,
    ROUND((product_views - cart_additions) * 100.0 /
          product_views, 2)      AS dropoff_view_to_cart,
    ROUND((cart_additions - checkouts) * 100.0 /
          cart_additions, 2)     AS dropoff_cart_to_checkout,
    ROUND((checkouts - purchases) * 100.0 /
          checkouts, 2)          AS dropoff_checkout_to_purchase
FROM funnel_stages;