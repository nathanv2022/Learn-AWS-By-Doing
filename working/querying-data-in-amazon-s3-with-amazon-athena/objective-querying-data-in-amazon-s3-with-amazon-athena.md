# Querying-data-in-amazon-s3-with-amazon-athena

## Introduction

Welcome to this hands-on AWS lab, where we'll query data stored in Amazon S3 with SQL queries in Amazon Athena. Let's get started!

## Objectives
Successfully complete this lab by achieving the following objectives:
  
  
### Create a Table from S3 Bucket Metadata

1.  Navigate to Amazon Athena.
2.  Configure settings to send query results to the S3 bucket.
3.  Create a table from the S3 bucket data using the following values:
    -   **Database:**  aws_service_logs
    -   **Table Name:**  cf_access_optimized
    -   **Location of Input Data Set:**  s3://<S3_BUCKET_NAME>/
    -   **Data Format:**  Parquet
4.  Bulk add columns using this data:
    
    `time timestamp, location string, bytes bigint, requestip string, method string, host string, uri string, status int, referrer string, useragent string, querystring string, cookie string, resulttype string, requestid string, hostheader string, requestprotocol string, requestbytes bigint, timetaken double, xforwardedfor string, sslprotocol string, sslcipher string, responseresulttype string, httpversion string`
    
5.  Create the following partitions:
    -   **Column Name**: year
    -   **Column Name**: month
    -   **Column Name**: day
6.  Click  **Create table**.

### Add Partition Metadata

1.  Open a new query tab.
    
2.  Run the following query:
    
    `MSCK REPAIR TABLE aws_service_logs.cf_access_optimized`
    
3.  Observe that the  `row count`  equals  `207535`  with the following query:
    
    `SELECT count(*) AS rowcount FROM aws_service_logs.cf_access_optimized`
    
4.  Verify the partitions were created with the following query:
    
    `SELECT * FROM aws_service_logs.cf_access_optimized order by time desc LIMIT 10`
    

### Query the Total Bytes Served in a Date Range

1.  Observe the  `bytes`  column from the following query:
    
    `SELECT * FROM aws_service_logs.cf_access_optimized WHERE time BETWEEN TIMESTAMP '2018-11-02' AND TIMESTAMP '2018-11-03'`
    
2.  Run the following query:
    
    `SELECT SUM(bytes) AS total_bytes FROM aws_service_logs.cf_access_optimized WHERE time BETWEEN TIMESTAMP '2018-11-02' AND TIMESTAMP '2018-11-03'`
    
3.  Observe the value for  `total_bytes`  equals  `87310409`.
