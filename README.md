# Azure Data Engineering Pipeline Project

## Introduction

In  this Azure data engineering pipeline project, I set out to build a data pipeline moving data from an on-prem SQL database through Azure Data Lake and ending in Microsoft Power BI. I used the public Microsoft dataset named 'Adventure Works 2025'. This is a fictional dataset which represents sales data of a sports retailer called Adventure Works. 
The pipeline was orchestrated using Azure Data Factory.

The full data pipeline diagram can be seen below:

![image of Azure data pipeline ](images\image_data-pipelineV2.png)

The pipeline ingested data from an on-prem SQL database into Azure Data Lake using the Medallion architecture. Data transformation and transfer within the Medallion architecture was done with Azure Databricks (PySpark). Thereafter, the data was loaded into Azure Synapse Analytics using a dynamic SQL script. Finally, I used Power BI to connect to Azure Synapse Analytics and create a dashboard.


## Tools I used

* **Microsoft SQL Server** - the source on-Prem SQL database management system that initially held the data

* **Azure Data Factory** - to orchestrate the ETL pipeline

* **Azure Data Lake** - to store the data in bronze, silver and gold containers according to Medallion architecture

* **Azure Databricks** - the platform to transform and move the data between the bronze, silver and gold containers using PySpark within Jupyter notebooks

* **Apache Spark (PySpark)** - the analytics enginer used within Azure Databricks to clean and transform the data accessed via PySpark Python API

* **Azure Synapse Analytics** - to load the data once it had been transformed 

* **Microsoft Power BI** - to visually analyse the data from Azure Synapse Analytics using Star Schema method

## ETL Data Workflow on Medallion Architecture
Below is a description of the end-to-end workflow based on the Medallion architecture. The code files can be accessed at the end of each numbered section.

1. **Ingestion (On-Prem to Bronze)**: 

   * Azure Data Factory ingests data from SQL Server

   * Data is extracted raw and converted to Parquet files in the Bronze Storage Container.

      Raw JSON output file for this ingestion activity can be accessed [here](code\datafactory\Raw-output\RAW_copy_all_tables_from_SQL-onPrem.json)



2. **Cleansing (Bronze to Silver)**:

   * Azure Databricks (PySpark ) reads the raw Bronze data and performs three cleansing tasks
   * First task is that it applies standard formatting to date column of YYYY-MM-DD
   * Second task is that it enforces the data column to be a Python date object
   * Third task is that it converts all database files from Parquet to Delta and transfers them over to Silver container
   
      The Jupyter Notebook file for this cleansing activity can be accessed [here](code\databricks\bronze-to-silver.ipynb)

3. **Final transformation (Silver to Gold)**:

   * Azure Databricks (PySpark ) reads the Silver data and applies standard column name formatting from Camelcase to Snake case
   
      Jupyter Notebook file for this cleansing activity can be accessed [here](code\databricks\silver-to-gold.ipynb)

4. **Warehouse Loading & Reporting**:

   * In Azure Synapse Analytics, I executed Dynamic SQL scripts to create Views of each Delta table ensuring original data integrity.

      SQL file for this loading activity can be accessed [here](code\azure-synapse\gold_create_views_for_all_tables.sql)

   * For visual data analysis, I then connected Power BI to Azure Synapse Analytics via the Azure Synapse connecotr. I created relationships within all tables according to the Star Schema method. The Star Schema can be seen in the below screenshot:
   ![image of Star Schema in Power BI](power-bi\star-schema_power-BI.png)
     Using the above Star Scehma, I created a Products and Revenue Dashboard with high-level KPI cards and sales performance visualisations.

     This Products and Revenue Dashboard can be seen in the below screenshot:
     ![image of Dashboard in Power BI](power-bi\dashboard_power-BI.png)

   The Power BI Template file (without the data model, to reduce file size) for this dashboard activity can be accessed [here](power-bi\Dashboard_data-engineer.pbit)


## Conclusion
