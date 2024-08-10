-- Create a catalog
CREATE CATALOG my_catalog;

-- Use the catalog
USE CATALOG my_catalog;

-- Create a managed table
CREATE TABLE my_managed_table (
    id INT,
    name STRING,
    created_at TIMESTAMP
);

-- Create an external table
CREATE TABLE my_external_table (
    id INT,
    name STRING,
    created_at TIMESTAMP
)
USING DELTA
LOCATION 'abfss://<container>@<storage-account-name>.dfs.core.windows.net/external-data/';


-- Create a dynamic view for row-level security
CREATE VIEW secure_view AS
SELECT *
FROM my_managed_table
WHERE user_id = current_user();

-- Create a dynamic view for column-level filtering
CREATE VIEW secure_column_view AS
SELECT 
    id,
    CASE 
        WHEN current_user() = 'admin' THEN name
        ELSE 'REDACTED'
    END AS name,
    created_at
FROM my_managed_table;

