-- Query 2: Cart Abandonment by Category and Device Type
-- Purpose: Identifies which product categories and device types
-- have the highest cart abandonment rates
-- Business Question 2: How does cart abandonment vary across
-- product categories and device types?

WITH cart_sessions AS (
    -- Identify sessions that reached add_to_cart
    -- and whether they subsequently completed a purchase
    SELECT
        e.session_id,
        p.category,
        s.device_type,
        MAX(CASE WHEN e.event_type = 'add_to_cart'
            THEN 1 ELSE 0 END)  AS reached_cart,
        MAX(CASE WHEN e.event_type = 'purchase'
            THEN 1 ELSE 0 END)  AS completed_purchase
    FROM events e
    JOIN sessions s ON e.session_id = s.session_id
    JOIN products p ON e.product_id = p.product_id
    WHERE e.event_type IN ('add_to_cart', 'purchase')
    GROUP BY e.session_id, p.category, s.device_type
)
SELECT
    category,
    device_type,
    COUNT(*)                        AS cart_sessions,
    SUM(completed_purchase)         AS purchases,
    SUM(reached_cart) - 
        SUM(completed_purchase)     AS abandoned_carts,
    ROUND(
        (SUM(reached_cart) - SUM(completed_purchase)) 
        * 100.0 / COUNT(*), 2)      AS abandonment_rate_pct,
    ROUND(
        SUM(completed_purchase) * 100.0 
        / COUNT(*), 2)              AS cart_conversion_rate_pct
FROM cart_sessions
WHERE reached_cart = 1
GROUP BY category, device_type
ORDER BY abandonment_rate_pct DESC;