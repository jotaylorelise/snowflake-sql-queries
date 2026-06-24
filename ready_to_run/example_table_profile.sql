-- Description: Quick profile of a table — row count, nulls, and distinct values per column
-- Author:      <your name>
-- Date:        2026-06-24
-- Variables:   Replace <schema.table> with your target table
-- Notes:       Run per column; swap in column names as needed.

-- 1. Row count and date range (if there's a timestamp column)
SELECT
    COUNT(*)                        AS total_rows,
    MIN(created_at)                 AS earliest,
    MAX(created_at)                 AS latest,
    COUNT(DISTINCT consumer_id)     AS unique_consumers
FROM <schema.table>
;

-- 2. Null rates for key columns (add/remove columns as needed)
SELECT
    COUNT(*) AS total,
    SUM(CASE WHEN consumer_id  IS NULL THEN 1 ELSE 0 END) AS consumer_id_nulls,
    SUM(CASE WHEN order_id     IS NULL THEN 1 ELSE 0 END) AS order_id_nulls,
    SUM(CASE WHEN created_at   IS NULL THEN 1 ELSE 0 END) AS created_at_nulls
FROM <schema.table>
;

-- 3. Top-N breakdown for a categorical column
SELECT
    <category_column>,
    COUNT(*) AS cnt,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER () * 100, 2) AS pct
FROM <schema.table>
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20
;
