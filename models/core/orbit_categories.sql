{{ config(materialized='table') }}

select
NORAD_CAT_ID,
ECCENTRICITY,
PERIOD,
INCLINATION,
SEMIMAJOR_AXIS,

-- https://en.wikipedia.org/wiki/Low_Earth_orbit
CASE WHEN ECCENTRICITY < 0.25 AND PERIOD <= 128 AND INCLINATION <= 128 AND SEMIMAJOR_AXIS <  8413 
THEN CASE 
    WHEN INCLINATION BETWEEN 80 AND 100 THEN 'PO'
    WHEN INCLINATION < 80 OR INCLINATION > 100 THEN 'LEO'
    ELSE 'OTHER'
    END

-- 24 hour orbit with no inclination and eccentricity
WHEN PERIOD BETWEEN 1430 AND 1440 AND
ECCENTRICITY BETWEEN 0 AND 0.01 AND 
INCLINATION BETWEEN 0 AND 1 THEN 'GEO'

-- 24 hour orbit with any inclination or eccentricity
WHEN PERIOD BETWEEN 1430 AND 1440 AND
(ECCENTRICITY > 0.01 OR INCLINATION > 1) THEN 'GSO'

-- https://en.wikipedia.org/wiki/Medium_Earth_orbit
WHEN SEMIMAJOR_AXIS BETWEEN 8413 AND 42164 AND 
PERIOD > 120 AND PERIOD < 1440 THEN 'MEO'

ELSE 'OTHER'
END AS ORBIT_CAT
FROM kestra-sandbox-449719.project_zoomcamp.spacetrack_gp_data