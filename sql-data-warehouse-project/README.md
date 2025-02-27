## SQL Data Warehouse from Scratch  
**SQL Data Warehouse from Scratch | Full Hands-On Data Engineering Project**

- Youtube Tutorial - [Link](https://www.youtube.com/watch?v=9GVqKuTVANE)
- Notion for Project Management - [Link](https://chlorinated-tortoise-8d2.notion.site/SQL-Data-Engineering-Project-19930acec9ca80e99c8fe4be5e1f1dc8?pvs=4)

### Requirement Analysis
#### Objective
Develop a modern data warehouse using SQL Server to consolidate sales data, enabling analytics and reporting.

#### Specifications
- Data Source: [CSV files](datasets/) (ERP and CRM) 
- Data Quality: Data Cleaning and Transformation prior to consuming
- Integration: To consolidate both sources into single data model
- Scope: Focus on latest dataset, and ignore historical data
- Documentation: Git Repository with README.md and SQL Scripts

#### Tools
- SQL Server
- Notion
- Github
- Excalidraw
- Dbeaver
  
### Design Data Architecture
- Data Warehouse -> Medallion Architecture

![Block Diagram: Data Architecture](images/data-architecture.svg)

### Project Initialization
- Naming Conventions - using snake_case (lowercase with underscores between words)
- Language - English, and avoid using SQL reserved words

 #### Table Naming Conventions
 **Bronze & Silver Layer Rules**
 - All names must start with source system name and original table names (no renaming of tables)
 - ```<source_system>_<table_name>```
 - Example: ```erp_sales```, ```crm_customers```

**Gold Layer Rules**
- All names must be meaningful, business-aligned names for tables, starting with the category prefix:

 | Category | Description | Example |
 | ------- | ----------- | -------- |
 | dim_ | Dimension table | dim_customers |
 | fact_ | Fact table | fact_sales |
 | agg_ | Aggregated table | agg_sales_monthly |

**Surrogate Keys**
- All primary keys in dimension tables must use suffix ```_key```
- Example: ```customer_key``` in ```dim_customers``` table

**Technical Columns**
- All technical columns must use prefix ```dwh_``` followed by descriptive meaning
- ```dwh_<column_name>``` - exclusive for system-generated metadata
- Example: ```dwh_load_date``` -> System-generated column used to store the date when the record was loaded

**Stored Procedure**
- All stored procedures must use prefix ```load_<layer>```
- Example: ```load_bronze``` -> Stored procedure to load data into bronze layer

### Build Bronze Layer
Step 1: Gather and Analyze the data sources by interviewing the Source System Expert (i.e. domain expert, product owner). [checklist](bonus/checklist.md)
  - Get the business context and ownership of the data
  - Understand architecture and technology stack
  - How to extract and load (size, scope, limitations & authentication)
  - Understand the data structure, data quality, and data relationships
  
Step 2: Coding and testing the script for data ingestion 
  - Create a database [code](scripts/0.1-init_database.sql)
  - Create tables for each source system [code](scripts/1.0-init_bronze.sql)
  - Bulk import data from CSV files 
  ![Bulk import data](images/bronze01.png)
    
  - Truncate and Insert, to clear the table before adding any new record (row) [code](scripts/1.1-trunc_bulk_bronze.sql)
  - Validate the data with SELECT * and SELECT COUNT(*)
  
STEP 2.1: Prepare the data ingestion code as stored procedure
  - Create a stored procedure to load data into bronze layer [code](scripts/1.2-load_bronze_sp.sql)
  - Execute the stored procedure to load data into bronze layer

STEP  2.2: Prepare the data ingestion with Error Handling and Monitoring [code](scripts/1.3-load_bronze_sp_check.sql)

Step 3: Validation for data completeness & schema checks

Step 4: Documentation and versioning of the process
![Block Diagram: Bronze Layer Data Flow](images/data-flow.svg)

### Build Silver Layer
Step 1: Analyzing: Explore & Understand the Data
![Block Diagram: Understanding the data Relation](images/bronze_layer.svg)

Step 1.5: Include metadata columns for additoinal information

Step 2: Coding for Data Cleansing
- Check Quality of Bronze Layer
- Write Data Tranformations 
- Insert into Silver Layer

Step 3: Validation for data correctness checks

Step 4: Documentation and versioning of the process
