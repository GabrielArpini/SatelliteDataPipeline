-- macros/orbit_category.sql

{% macro orbit_category(eccentricity, period, inclination, semimajor_axis) %}

  CASE 
    -- Low Earth Orbit (LEO/PO)
    WHEN {{ eccentricity }} < 0.25 
         AND {{ period }} <= 128 
         AND {{ inclination }} <= 128 
         AND {{ semimajor_axis }} < 8413 THEN 
      CASE 
        WHEN {{ inclination }} BETWEEN 80 AND 100 THEN 'PO'
        WHEN {{ inclination }} < 80 OR {{ inclination }} > 100 THEN 'LEO'
        ELSE 'OTHER'
      END

    -- GEO - 24 hour orbit with no inclination and eccentricity
    WHEN {{ period }} BETWEEN 1430 AND 1440 
         AND {{ eccentricity }} BETWEEN 0 AND 0.01 
         AND {{ inclination }} BETWEEN 0 AND 1 THEN 'GEO'

    -- GSO - 24 hour orbit with any inclination or eccentricity
    WHEN {{ period }} BETWEEN 1430 AND 1440 
         AND ({{ eccentricity }} > 0.01 OR {{ inclination }} > 1) THEN 'GSO'

    -- Medium Earth Orbit (MEO)
    WHEN {{ semimajor_axis }} BETWEEN 8413 AND 42164 
         AND {{ period }} > 120 
         AND {{ period }} < 1440 THEN 'MEO'

    ELSE 'OTHER'
  END

{% endmacro %}
