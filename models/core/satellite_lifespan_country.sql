{{ config(materialized='table') }}

SELECT COUNTRY_CODE,
AVG(DATE_DIFF(DECAY_DATE, LAUNCH_DATE, DAY)) AS AVG_LIFESPAN,
MIN(DATE_DIFF(DECAY_DATE, LAUNCH_DATE, DAY)) AS MIN_LIFESPAN,
MAX(DATE_DIFF(DECAY_DATE, LAUNCH_DATE, DAY)) AS MAX_LIFESPAN
FROM kestra-sandbox-449719.project_zoomcamp.spacetrack_gp_data
WHERE DECAY_DATE IS NOT NULL AND LAUNCH_DATE IS NOT NULL
GROUP BY COUNTRY_CODE
ORDER BY 1 ASC