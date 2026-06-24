-- Description: Weekly core business metrics — orders, GMV, and unique consumers
-- Author:      <your name>
-- Date:        2026-06-24
-- Variables:   {{ lookback_weeks }}
-- Notes:       Partitioned by week_start (Monday). Adjust WHERE clause for your market.

WITH
weekly AS (
    SELECT
        DATE_TRUNC('week', created_at)::DATE AS week_start,
        COUNT(DISTINCT order_id)             AS orders,
        COUNT(DISTINCT consumer_id)          AS unique_consumers,
        SUM(subtotal_usd)                    AS gmv_usd,
        SUM(subtotal_usd) / NULLIF(COUNT(DISTINCT order_id), 0) AS avg_order_value
    FROM orders_schema.orders
    WHERE created_at >= DATEADD('week', -{{ lookback_weeks }}, CURRENT_DATE)
        AND order_status = 'delivered'
    GROUP BY 1
)

SELECT
    week_start,
    orders,
    unique_consumers,
    ROUND(gmv_usd, 2)          AS gmv_usd,
    ROUND(avg_order_value, 2)  AS avg_order_value,
    -- WoW deltas
    orders - LAG(orders) OVER (ORDER BY week_start)             AS orders_wow_delta,
    ROUND(
        (orders - LAG(orders) OVER (ORDER BY week_start))
        / NULLIF(LAG(orders) OVER (ORDER BY week_start), 0) * 100, 1
    )                                                            AS orders_wow_pct
FROM weekly
ORDER BY week_start DESC
;
