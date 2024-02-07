# New York Times articles dashboard
ETL pipeline on the New York Times data with apache superset for data visualization


## Problem

## Motivation

## Data source

https://developer.nytimes.com/docs/archive-product/1/overview

## Solution

API --> mage --> GCP data lake --> BigQuery --> dbt --> Bigquery --> Looker studio.

Terraform


Tools and infrastructure
Data pipeline
Orchestration
...



Instructions / project overview:

- create gcp account
	- create new project
	- create a vm instance
	
	
- connect to the vm instance
- pull the project repo
- run docker compose to run the pipelines/project:
	- terraform to create the required infrastructure in GCP
		- data lake bucket
		- data warehouse with the proper datasets: staging, production
		- IAM for looker
		- IAM for mage ai pipelines (read/write on data lake, read/write on data warehouse, create datasets on data warehouse...)
	- mage ai to run the pipelines (for each pipelines, run tests in data quality).
		- one ETL pipeline to load into the data lake (API -> transform -> data lake)
		- one ETL pipeline to load into the data warehouse (data lake -> transform -> data warehouse)
		- one dbt pipeline to create the data model in the warehouse (staging --> serving)
	- looker studio... to display the dashboard.
	
	
CI/CD:
- implement CI/CD as if this project was always in production and we used CI/CD to add features to it.



## Results
Dashboard

## Inspiration
https://github.com/LoHertel/diplomats-in-germany/tree/main


## Instructions:
- run `docker compose up`
- 
