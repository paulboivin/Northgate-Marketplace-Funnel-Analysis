-- Query 4: Revenue Impact of Cart Abandonment

-- This query quantifies the potential revenue lost at the
-- cart abandonment stage by category.

-- How much potential revenue is being lost at the cart abandonment stage?


WITH cart_events AS (
	 -- Identifies all add_to_cart events with product
     -- and price information.
    SELECT
        e.session_id,
        e.product_id,
        p.category,
        p.product_name,
        e.price_at_event,
        s.device_type
    FROM events e
    JOIN products p ON e.product_id = p.product_id
    JOIN sessions s ON e.session_id = s.session_id
    WHERE e.event_type = 'add_to_cart'
),
purchase_sessions AS (
	 -- Identifies sessions that completed a purchase.
    SELECT DISTINCT session_id
    FROM events
    WHERE event_type = 'purchase'
),
abandoned AS (
	 -- Identifies cart events where no purchase was completed.
     -- These represent lost revenue opportunities.
    SELECT
        ce.session_id,
        ce.product_id,
        ce.category,
        ce.product_name,
        ce.price_at_event,
        ce.device_type
    FROM cart_events ce
    LEFT JOIN purchase_sessions ps
        ON ce.session_id = ps.session_id
    WHERE ps.session_id IS NULL
),
total_carts_by_category AS (
    SELECT
        p.category,
        COUNT(*) AS total_cart_sessions
    FROM events e
    JOIN products p ON e.product_id = p.product_id
    WHERE e.event_type = 'add_to_cart'
    GROUP BY p.category
)
SELECT
    a.category,
    COUNT(*)                                AS abandoned_carts,
    t.total_cart_sessions,
    ROUND(COUNT(*) * 100.0 /
          t.total_cart_sessions, 2)         AS category_abandonment_rate_pct,
    ROUND(AVG(a.price_at_event), 2)         AS avg_abandoned_price,
    ROUND(SUM(a.price_at_event), 2)         AS total_lost_revenue,
    ROUND(SUM(a.price_at_event) * 100.0 /
          SUM(SUM(a.price_at_event))
          OVER (), 2)                       AS pct_of_total_lost
FROM abandoned a
JOIN total_carts_by_category t
    ON a.category = t.category
GROUP BY a.category
ORDER BY total_lost_revenue DESC;