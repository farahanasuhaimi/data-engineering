BULK INSERT bronze.crm_cust_info
FROM "D:\Kerja\Practices\data-engineering\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
WITH (
FIRSTROW = 2,
FIELDTERMINATOR=',',
TABLOCK
)

SELECT * FROM bronze.crm_cust_info