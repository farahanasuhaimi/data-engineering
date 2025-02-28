/*
=======================

=======================

*/

-- Check for NULLs or DUPLICATES in Primary Key

SELECT cst_id, COUNT(*) 
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL