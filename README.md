# SatelliteDataPipeline

## ABOUT
This project aims to visualize data from the `space-track.org` API that contains information about in-orbit objects, launch information, if known, and other useful information about satellites. The dataset contains 40 columns and is difficult to visualize how each column relates with others, with that in mind, i've developed a data engineering pipeline to extract the data from the API and load it into the GCP environment and transform it using DBT to create dashboards and analyse patterns, correlations, etc.

## The problem
It is not easy to associate how each feature of the dataset interacts which each other and gather important insights about satellite launches and in-orbit objects, with that in mind, i've decided to create a pipeline that extract data from the RESTful API every day and create some tables that compile important information together with dbt (data build tool) to help visualize and gather insights about the daily updated dataset content.

## The pipeline



