# Snowflake SQL Queries

A shared library of reusable Snowflake SQL queries organized by purpose.

## Structure

```
snowflake-sql-queries/
├── analytics/          # Funnel, cohort, and behavioral analysis
├── reporting/          # Recurring reports and dashboards
├── data_exploration/   # Ad-hoc exploration and table profiling
└── templates/          # Boilerplate to copy-paste from
```

## Conventions

- File names use `snake_case` and describe what the query does, e.g. `weekly_cx_satisfaction.sql`
- Each file includes a header comment with: description, author, date, and any required variables
- Variables are written as `{{ variable_name }}` for easy substitution
- CTEs are preferred over subqueries for readability

## Header template

```sql
-- Description: <one-line summary>
-- Author:      <your name>
-- Date:        <YYYY-MM-DD>
-- Variables:   <list any {{ vars }} used>
-- Notes:       <optional>
```

## Contributing

1. Place your query in the most relevant folder
2. Follow the header convention above
3. Test before committing
