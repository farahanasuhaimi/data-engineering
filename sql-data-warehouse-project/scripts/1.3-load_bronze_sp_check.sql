/*
=====================
Load Bronze Layer with Error Handling and Monitoring
=====================

This scripts creates a stored procedure with checking of start and end time, error handling, and print statements.
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_load DATETIME, @end_time_load DATETIME;
	
	BEGIN TRY
		SET @start_time_load = GETDATE();
		PRINT '=================';
		PRINT 'Loading Bronze Layer';
		PRINT '=================';

		PRINT '-----------------';
		PRINT 'Loading CRM Tables';
		PRINT '-----------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM "D:\Kerja\Practices\data-engineering\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';


		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM "D:\Kerja\Practices\data-engineering\sql-data-warehouse-project\datasets\source_crm\prd_info.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM "D:\Kerja\Practices\data-engineering\sql-data-warehouse-project\datasets\source_crm\sales_details.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

		PRINT '-----------------';
		PRINT 'Loading ERP Tables';
		PRINT '-----------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM "D:\Kerja\Practices\data-engineering\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM "D:\Kerja\Practices\data-engineering\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM "D:\Kerja\Practices\data-engineering\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv"
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR =',',
		TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Loading duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds.';
		SET @end_time_load = GETDATE();
		PRINT '===========================================';
		PRINT 'Loading Bronze Layer is completed.';
		PRINT '>> Total Load duration: ' + CAST(DATEDIFF(second, @start_time_load, @end_time_load) AS NVARCHAR) + ' seconds.';
		PRINT '===========================================';


	END TRY
	BEGIN CATCH
		PRINT '===========================================';
		PRINT 'ERROR occured during Loading Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===========================================';

	END CATCH
END