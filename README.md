# SatelliteDataPipeline

## About
This project aims to visualize data from the `space-track.org` API that contains information about in-orbit objects, launch information, if known, and other useful information about satellites. The dataset contains 40 columns and is difficult to visualize how each column relates with others, with that in mind, i've developed a data engineering pipeline to extract the data from the API and load it into the GCP environment and transform it using DBT to create dashboards and analyse patterns, correlations, etc.

## The problem
It is not easy to associate how each feature of the dataset interacts which each other and gather important insights about satellite launches and in-orbit objects, with that in mind, i've decided to create a pipeline that extract data from the RESTful API every day and create some tables that compile important information together with dbt (data build tool) to help visualize and gather insights about the daily updated dataset content.

## The pipeline

![image](imgs/ELT_pipeline.png) –

The pipeline to achive this project objectives is an ELT pipeline, which extracts data from a RESTful API from the source website as an `.csv` file, the API contains multiple datasets to choose, i've choosen the GP (General Pertubations) dataset, because it not only contains known objects but it also contains filtered unknown objects that are detected using RCS (Radar Cross Section). To extract said file, it is used a `python script` within `Kestra`, which is the workflow orchestrator, this script downloads the .csv file and outputs it inside Kestra internal variables so it can be used in the following task to upload it inside a GCP (Google Cloud Platform) Bucket, from there it is loaded inside BigQuery without transformations

