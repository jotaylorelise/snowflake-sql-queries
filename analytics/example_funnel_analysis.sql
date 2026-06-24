-- Description: Conversion funnel from session start to order placed
-- Author:      <your name>
-- Date:        2026-06-24
-- Variables:   {{ start_date }}, {{ end_date }}

WITH
events AS (
    SELECT
        consumer_id,
        event_name,
        event_timestamp
    FROM event_schema.consumer_events
    WHERE event_timestamp::DATE BETWEEN '{{ start_date }}' AND '{{ end_date }}'
        AND event_name IN ('session_start', 'store_viewed', 'item_added', 'checkout_started', 'order_placed')
),

funnel AS (
    SELECT
        consumer_id,
        MAX(CASE WHEN event_name = 'session_start'      THEN 1 ELSE 0 END) AS had_session,
        MAX(CASE WHEN event_name = 'store_viewed'       THEN 1 ELSE 0 END) AS viewed_store,
        MAX(CASE WHEN event_name = 'item_added'         THEN 1 ELSE 0 END) AS added_item,
        MAX(CASE WHEN event_name = 'checkout_started'   THEN 1 ELSE 0 END) AS started_checkout,
        MAX(CASE WHEN event_name = 'order_placed'       THEN 1 ELSE 0 END) AS placed_order
    FROM events
    GROUP BY 1
)

SELECT
    SUM(had_session)        AS sessions,
    SUM(viewed_store)       AS store_views,
    SUM(added_item)         AS add_to_carts,
    SUM(started_checkout)   AS checkouts_started,
    SUM(placed_order)       AS orders_placed,
    ROUND(SUM(placed_order) / NULLIF(SUM(had_session), 0) * 100, 2) AS session_to_order_pct
FROM funnel
;
