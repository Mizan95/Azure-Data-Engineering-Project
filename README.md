# Azure Data Engineering Pipeline Project

## Introduction

In  this Azure data engineering pipeline project, I set out to build a pipeline moving data from an on-prem SQL database through Azure Data Lake and ending in Microsoft Power BI. The pipeline was orchestrated using Azure Data Factory.

The full data pipeline diagram can be seen below:

![image_data-pipelineV2.png](C:\Users\Mizan\Documents\SQL_Data-Engineering-Project\files_project_data-engineering\image_data-pipelineV2.png)

The pipeline ingested data from an on-prem SQL database into Azure Data Lake using the Medallion architecture. Data transformation and transfer within the Medallion architecture was done with Azure Databricks (PySpark). Thereafter, the data was loaded into Azure Synapse Analytics using a dynamic SQL script. Finally, I used Power BI to connect to Azure Synapse Analytics and create a dashboard.


## Tools I used

* Microsoft SQL Server - the source on-Prem SQL database management system that initially held the data

* Azure Data Factory - to orchestrate the ETL pipeline

* Azure Data Lake - to store the data in bronze, silver and gold containers according to Medallion architecture

* Azure Databricks - the platform to transform and move the data between the bronze, silver and gold containers using PySpark within Jupyter notebooks

* Apache Spark (PySpark) - the analytics enginer used within Azure Databricks to clean and transform the data accessed via PySpark Python API

* Azure Synapse Analytics - to load the data once it had been transformed 

* Microsoft Power BI - to visually analyse the data from Azure Synapse Analytics using Star Schema method

## Medallion Data Workflow

1. **Ingestion (On-Prem to Bronze)**: 

   * Azure Data Factory ingests data from SQL Server

   * Data is landed raw and converted to Parquet files in the Bronze Storage Container.

   * Data is landed raw and converted to Parquet files in the Bronze Storage Container.

     <mark>Raw JSON output file for this ingestion activity can be accessed here:</mark>

2. **Cleansing (Bronze to Silver)**:

   * Azure Databricks (PySpark ) reads the raw Bronze data and performs three cleansing tasks
   * First task is that it applies standard formatting to date column of YYYY-MM-DD
   * Second task is that it enforces the data column to be a Python date object
   * Third task is that it converts all database files from Parquet to Delta and transfers them over to Silver container
   * <mark>Jupyter Notebook file for this cleansing activity can be accessed here:</mark>

3. **Final transformation (Silver to Gold)**:

   * Azure Databricks (PySpark ) reads the Silver data and applies standard column name formatting from Camelcase to Snake case
   * <mark>Jupyter Notebook file for this cleansing activity can be accessed here:</mark>

4. **Warehouse Loading & Reporting**:

   * In Azure Synapse Analytics, I executed dynamic SQL scripts to create Views of each Delta table ensuring original data integrity.

   * <mark>SQL file for this loading activity can be accessed here:</mark>

   * Power BI connected to Azure Synapse Analytics Azure Synapse Analytics connected to Power BI for visual data analysis. I created relationships within all tables according to Star Schema method. The Star Schema can be seen in the below screenshot:

     Using the above Star Scehma, I created a Products and Revenue Dashboard with high-level KPI cards and sales performance visualisations.

     This Products and Revenue Dashboard can be seen in the below screenshot:

![star-schema_power-BI.png](C:\Users\Mizan\Documents\SQL_Data-Engineering-Project\files_project_data-engineering\power-bi\star-schema_power-BI.png)

![dashboard_power-BI.png](C:\Users\Mizan\Documents\SQL_Data-Engineering-Project\files_project_data-engineering\power-bi\dashboard_power-BI.png)

<mark>Power BI Template file for this dashboard activity can be accessed here:</mark>


## Conclusion
