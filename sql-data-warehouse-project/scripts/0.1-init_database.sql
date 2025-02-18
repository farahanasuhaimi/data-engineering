/*
=========================
Create Database and Schemas
=========================
This script creates a new database called 'DataWarehouse' and three schemas: 'bronze', 'silver', and 'gold'.

WARNING: Running this script will drop the 'DataWarehouse' database if it already exists.
*/

-- Create Database 'DataWarehouse'
use master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;

use DataWarehouse;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;