-- Description: <one-line summary of what this query does>
-- Author:      <your name>
-- Date:        <YYYY-MM-DD>
-- Variables:   {{ start_date }}, {{ end_date }}
-- Notes:       <any caveats, data gotchas, or links to context>

WITH
base AS (
    SELECT
        -- your base data here
    FROM schema.table
    WHERE created_at BETWEEN '{{ start_date }}' AND '{{ end_date }}'
),

filtered AS (
    SELECT *
    FROM base
    WHERE 1=1
        -- AND some_condition = true
)

SELECT *
FROM filtered
ORDER BY 1
;
