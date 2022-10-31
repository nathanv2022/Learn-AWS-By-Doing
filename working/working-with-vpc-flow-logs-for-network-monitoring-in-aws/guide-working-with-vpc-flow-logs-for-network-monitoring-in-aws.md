
# Working with VPC Flow Logs for Network Monitoring in AWS


## Description

This hands-on lab gives you the opportunity to work with VPC Flow Logs. It will teach various ways to review VPC Flow Logs and monitor networks. A common way people evaluate VPC Flow Logs is by sending them to CloudWatch. Once they're in CloudWatch, people can create metrics, then set alarms based on those metrics. Additionally, it's possible to export CloudWatch Logs to S3. In fact, it's possible to export VPC Flow Logs directly to S3. The advantages of this are cost savings and ease of use. In this hands-on lab, we will go through the process of exporting VPC Flow Logs to S3, as well as use Amazon Athena to query those Flow Logs.

## Objectives

### Create an S3 Bucket

1.  Navigate to S3.
2.  Click  **Create Bucket**.
3.  Give the bucket a unique name (e.g., "vpcflow4learningactivity" and a series of numbers at the end, like the account ID of the AWS account provisioned with the lab, to make it globally unique).
4.  Click  **Next**  three times.
5.  Click  **Create Bucket**.
6.  Click to open your newly created bucket.
7.  Click  **Create folder**.
8.  In the box next to the folder, enter "AWSLogs".
9.  Click  **Save**.
10.  Click  **Create folder**.
11.  In the box next to the folder, enter "QueryResults".
12.  Click  **Save**.

### Configure VPC Flow Logs

1.  Navigate to  **VPC**  >  **Your VPCs**.
2.  Select the  `LinuxAcademy`  VPC.
3.  Click  **Actions**  >  **Create flow log**.
4.  Set the following values:
    -   _Filter_:  **All**
    -   _Destination_:  **Send to an S3 bucket**
    -   _S3 bucket ARN_:  **`arn:aws:s3:::<YOUR_BUCKET_NAME>`**
5.  Click  **Create**.
6.  Click the  **Flow Logs**  tab to verify the flow log exists.

### Create and Query a Sample Table in Amazon Athena

1.  In Athena, specify the  _QueryResults_  folder in the S3 bucket as the query results location.
2.  Use the Athena tutorial to create a sample table.
3.  Run a  `select * from`  query on the table.
4.  Edit the query by replacing  `*`  with  `request_ip`  and run it again.

### Configure and Query the VPC Flow Logs

1.  In S3, verify that logs have populated the  _AWSLogs_  folder in the  _vpcflow4learningactivity_  bucket.
2.  In Athena, run the scripts provided on the lab page.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Create an S3 Bucket

1.  Navigate to S3.
2.  Click  **Create bucket**.
3.  Under  _Bucket name_  enter "vpcflow4learningactivity" and a series of numbers at the end (e.g., the account ID of the AWS account provisioned with the lab) to make it globally unique.
4.  Click  **Create bucket**.

### Create a Folder for the VPC Flow Logs and Athena Query Results

1.  Click the link for the newly-created bucket.
2.  Click  **Create folder**.
3.  In the box next to the folder, enter "AWSLogs".
4.  Click  **Save**.
5.  Click  **Create folder**  again.
6.  Give it the name "QueryResults".
7.  Click  **Save**.

### Create a Flow Log

1.  In a new browser tab, navigate to  **VPC**  >  **Your VPCs**.
2.  Select the  `LinuxAcademy`  VPC.
3.  Click  **Actions**  >  **Create flow log**.
4.  Set the following values:
    -   _Filter_:  **All**
    -   _Destination_:  **Send to an S3 bucket**
    -   _S3 bucket ARN_:  **`arn:aws:s3:::<YOUR_BUCKET_NAME>`**
5.  Click  **Create**.
6.  Click the  **Flow Logs**  tab to verify the flow log exists.
    
    > _Note_: It can take 5-15 minutes before logs start to show up, so let's move on while we wait for that to happen.
    

### Create and Query a Sample Table in Amazon Athena

1.  In a new browser tab, navigate to Athena.
2.  Click  **Get Started**.
3.  Set up a bucket to store results. Note that this part is required due to changes in AWS but is not in the video.
    1.  Click  **Settings**  in the top ribbon.
    2.  In the box for  _Query result location_, enter  **`s3://<YOUR_BUCKET_NAME>/QueryResults/`**  remembering to use the name of the bucket created earlier.
    3.  Click  **Save**.
4.  At the top of the browser, click  **Tutorial**  to start the tutorial.
5.  In the tutorial window that pops up, click  **Next**, then  **Next**  again.
6.  The following tutorial window pops up along with an  _Add table_  window. In there:
    -   Enter  **athenademo**  in the box provided for the name of the database.
    -   Enter  **elb_logs**  in the box provided for the name of the new table.
    -   In the  _Location of Input Data Set_  box, copy the string from the tutorial window.
    -   Click  **Next**  in  _this_  window (not the tutorial).
    -   In the next window, set the  _Data Format_  to  **Apache Web Logs**, and paste the regular expression from the tutorial window into the  _Regex_  field in the  _Add table_  window. Then click  **Next**.
7.  Back in the tutorial window (which should have a  _Columns_  title) click where it says "Click  **here**" down toward the bottom. This will autopopulate the  _Column Name_  and  _Column type_  fields.
8.  Click  **Next**  in the  _Add table_  window, then  **Next**  in the tutorial window.
9.  Click  **Run query**, and our table will start to be created. We can close the tutorial window now.

## Run a Couple of Test Queries

1.  Click the  **+**  tab to create a new query.
2.  In the query box, enter the following:
    
    `select * from athenademo.elb_logs`
    
3.  Click  **Run query**.
4.  Replace  `*`  in the query with  `request_ip`.
5.  Click  **Run query**. It may take a few minutes to complete.

### Configure and Query the VPC Flow Logs

1.  In the S3 browser tab, click to open your bucket.
    
2.  Click  **AWSLogs**.
    
    -   Note that it can take 10–15 minutes for data to populate, so give it some time if you don't immediately see anything in the folder.
3.  Click the folder with the account number.
    
4.  Click  **vpcflowlogs**.
    
5.  Click  **us-east-1**.
    
6.  Click on the folder with the current year.
    
7.  Click on the folder with the current month.
    
8.  Click on the folder with the current day.
    
9.  Verify that logs have populated this folder.
    
10.  In the  **Athena**  >  **Query Editor**  browser tab, click the  **+**  tab to create a new query.
    
11.  Copy and paste the following script into the query box:
    
    `CREATE EXTERNAL TABLE IF NOT EXISTS vpc_flow_logs ( version int, account string, interfaceid string, sourceaddress string, destinationaddress string, sourceport int, destinationport int, protocol int, numpackets int, numbytes bigint, starttime int, endtime int, action string, logstatus string ) PARTITIONED BY (dt string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' LOCATION 's3://your_log_bucket/prefix/AWSLogs/{subscribe_account_id}/vpcflowlogs/{region_code}/' TBLPROPERTIES ("skip.header.line.count"="1");`
    
12.  Edit the script:
    
    -   Replace  `your_log_bucket`  with the name of your bucket.
    -   Remove  `prefix/`.
    -   Replace  `{subscribe_account_id}`  with the account ID (_without_  dashes) for  `cloud_user`.
    -   Change  `{region-code}`  to  `us-east-1`.
13.  Click  **Run query**.
    
14.  Click the  **+**  tab to create a new query.
    
15.  Enter the following:
    
    `ALTER TABLE vpc_flow_logs ADD PARTITION (dt='YYYY-MM-dd') location 's3://your_log_bucket/prefix/AWSLogs/{account_id}/vpcflowlogs/{region_code}/YYYY/MM/dd'`
    
16.  Edit the script:
    
    -   Replace  `YYYY-MM-dd`  with the current date. For month and day, use two digits if it is a single-digit date.
    -   Replace  `your_log_bucket`  with the name of your bucket.
    -   Remove  `prefix/`.
    -   Replace  `{account_id}`  with the account ID (_without_  dashes) for  `cloud_user`.
    -   Change  `{region-code}`  to  `us-east-1`.
    -   Replace  `YYYY-MM-dd`  with the current date. For month and day, use two digits if it is a single-digit date (like,  **02**  for February).
17.  Click  **Run query**.
    
18.  Click the  **+**  tab to create a new query.
    
19.  Enter the following into the query box:
    
    `select * from vpc_flow_logs`
    
20.  Click  **Run query**.
    

## Conclusion

Congratulations — you've successfully completed this hands-on lab!
