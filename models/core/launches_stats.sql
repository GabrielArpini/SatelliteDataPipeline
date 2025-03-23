{{ config(materialized='table') }}


WITH LAUNCH_INFO AS (
  SELECT
    COUNTRY_CODE,
    LAUNCH_DATE,
    EXTRACT(YEAR FROM LAUNCH_DATE) AS YEAR,
    EXTRACT(MONTH FROM LAUNCH_DATE) AS MONTH
  FROM {{ source('project_zoomcamp', 'spacetrack_gp_data') }}
  WHERE OBJECT_TYPE = 'PAYLOAD'
),

COUNTRY_MONTH_LAUNCHES AS (
  SELECT
    COUNTRY_CODE,
    YEAR,
    MONTH,
    COUNT(*) AS LAUNCHES
  FROM LAUNCH_INFO
  GROUP BY COUNTRY_CODE, YEAR, MONTH
),

LAUNCH_STATS AS (
  SELECT
    COUNTRY_CODE,
    YEAR,
    SUM(LAUNCHES) AS TOTAL_LAUNCHES,
    COUNT(MONTH) AS ACTIVE_MONTHS_COUNT,
    AVG(LAUNCHES) AS AVG_MONTHLY_LAUNCHES,
    STDDEV(LAUNCHES) AS MONTHLY_LAUNCHES_STDDEV,
    STDDEV(LAUNCHES) / NULLIF(AVG(LAUNCHES), 0) AS LAUNCH_CV
  FROM COUNTRY_MONTH_LAUNCHES
  GROUP BY COUNTRY_CODE, YEAR
)

SELECT * 
FROM LAUNCH_STATS
ORDER BY YEAR ASC, TOTAL_LAUNCHES DESC
