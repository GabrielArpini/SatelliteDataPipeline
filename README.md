# SatelliteDataPipeline

## ABOUT
This project aims to visualize data from the `space-track.org` API that contains information about in-orbit objects, launch information, if known, and other useful information about satellites. The dataset contains 40 columns and is difficult to visualize how each column relates with others, with that in mind, i've developed a data engineering pipeline to extract the data from the API and load it into the GCP environment and transform it using DBT to create dashboards and analyse patterns, correlations, etc.

## The pipeline
