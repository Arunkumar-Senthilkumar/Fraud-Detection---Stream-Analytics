create DATABASE fraud_db;
use fraud_db 
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Welcome@123'

CREATE DATABASE scoped CREDENTIAL democredential 
with IDENTITY='SHARED ACCESS SIGNATURE',
SECRET='sv=2024-11-04&ss=bfqt&srt=sco&sp=rwdlacupyx&se=2025-03-23T07:31:06Z&st=2025-03-22T23:31:06Z&spr=https&sig=%2FqbQhm9lhnrElHsUjUNvPI5XY3HIuen3rpfA3R7dEOs%3D'
GO

CREATE EXTERNAL DATA SOURCE demo_data_source with(
    LOCATION='https://fdadls.dfs.core.windows.net',
    CREDENTIAL=democredential
);
drop external file format JsonLinesFormat;
CREATE EXTERNAL FILE FORMAT file_format_name
WITH (
         FORMAT_TYPE = PARQUET
);



drop EXTERNAL table transaction_table;

create EXTERNAL TABLE transaction_table(
    transaction_id NVARCHAR(50),
    user_id NVARCHAR(50),
    timestamp NVARCHAR(100),
    amount BIGINT,
    currency NVARCHAR(10),
    location NVARCHAR(100),
    device NVARCHAR(50),
    ip_address NVARCHAR(50),
    merchant_id NVARCHAR(50),
    transaction_type NVARCHAR(50),
    is_fraud BIT,
    fraud_reason NVARCHAR(100),
    rapid_transaction_flag NVARCHAR(50))
with(
    LOCATION='curated/**',
    DATA_SOURCE=demo_data_source,
    FILE_FORMAT=file_format_name
);