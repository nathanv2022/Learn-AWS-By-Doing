
# Work with AWS VPC Flow Logs for Network Monitoring


## Description

Monitoring network traffic is a critical component of security best practices to meet compliance requirements, investigate security incidents, track key metrics, and configure automated notifications. AWS VPC Flow Logs captures information about the IP traffic going to and from network interfaces in your VPC. In this hands-on lab, we will set up and use VPC Flow Logs published to Amazon CloudWatch, create custom metrics and alerts based on the CloudWatch logs to understand trends and receive notifications for potential security issues, and use Amazon Athena to query and analyze VPC Flow Logs stored in S3.

## Objectives

### Create CloudWatch Log Group and VPC Flow Log to CloudWatch

1.  Create a VPC Flow Log to S3, setting the  _Maximum aggregation interval_  to 1 minute and the  _S3 bucket ARN_  to the  **VPC Flow Logs S3 Bucket ARN**  found in the lab credentials or obtained via S3.
2.  Create a CloudWatch log group. Name it  **VPCFlowLogs**.
3.  Create a VPC Flow Log to CloudWatch using the IAM role provided for the lab (the one with  _DeliverVPCFlowLogsRole_  in the name) and the CloudWatch log group you created.
4.  Generate some traffic for the flow logs.

### Create CloudWatch Filters and Alerts

_Note that there may be a  **New Console Experience**  button in the top-left of the CloudWatch console. These instructions are designed for this new layout, so ensure this is toggled (if it is present.)_

1.  Create a CloudWatch log metric filter named  `dest-port-22-rejects`. For the  _Metric namespace_, use  `VPC Flow logs`, for  _Metric name_, use  `ssh-rejects`, and for  _Metric value_, enter  `1`.
    
    -   Use the below filter pattern:
        
        `[version, account, eni, source, destination, srcport, destport="22", protocol="6", packets, bytes, windowstart, windowend, action="REJECT", flowlogstatus]`
        
    -   Use the following for the log data:
        
        `2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 22 6 1 40 1563108188 1563108227 REJECT OK 2 086112738802 eni-0d5d75b41f9befe9e 182.68.238.8 172.31.83.158 42227 22 6 1 44 1563109030 1563109067 REJECT OK 2 086112738802 eni-0d5d75b41f9befe9e 42.171.23.181 172.31.83.158 52417 22 6 24 4065 1563191069 1563191121 ACCEPT OK 2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 80 6 1 40 1563108188 1563108227 REJECT OK`
        
2.  Create an alarm called  `SSH-rejects`  based on the metric filter.
    

### Use CloudWatch Insights

Apply the  _Top 20 source IP addresses with highest number of rejected requests_  sample query.

### Analyze VPC Flow Logs Data in Athena

1.  Create the Athena table:
    
    `CREATE EXTERNAL TABLE IF NOT EXISTS default.vpc_flow_logs ( version int, account string, interfaceid string, sourceaddress string, destinationaddress string, sourceport int, destinationport int, protocol int, numpackets int, numbytes bigint, starttime int, endtime int, action string, logstatus string ) PARTITIONED BY (dt string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' LOCATION 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/' TBLPROPERTIES ("skip.header.line.count"="1");`
    
2.  Create partitions to be able to read the data:
    
    `ALTER TABLE default.vpc_flow_logs ADD PARTITION (dt='{Year}-{Month}-{Day}') location 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/{Year}/{Month}/{Day}';`
    
3.  Run the following query in a new query window:
    
    `SELECT day_of_week(from_iso8601_timestamp(dt)) AS day, dt, interfaceid, sourceaddress, destinationport, action, protocol FROM vpc_flow_logs WHERE action = 'REJECT' AND protocol = 6 order by sourceaddress LIMIT 100;`
    

## Additional Resources

Log in to the live AWS environment using the credentials provided. Make sure you are using  `us-east-1`  (N. Virginia) as the selected region.

**Note:**  Please use the original, older user interface of Athena for this hands on lab activity. We have notified the lab creator, who will be scheduling an update to the lab.

### CloudWatch Log Metric Filter Pattern

`[version, account, eni, source, destination, srcport, destport="22", protocol="6", packets, bytes, windowstart, windowend, action="REJECT", flowlogstatus]`

### Custom Log Data to Test

`2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 22 6 1 40 1563108188 1563108227 REJECT OK 2 086112738802 eni-0d5d75b41f9befe9e 182.68.238.8 172.31.83.158 42227 22 6 1 44 1563109030 1563109067 REJECT OK 2 086112738802 eni-0d5d75b41f9befe9e 42.171.23.181 172.31.83.158 52417 22 6 24 4065 1563191069 1563191121 ACCEPT OK 2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 80 6 1 40 1563108188 1563108227 REJECT OK`

### Create Athena Table

`CREATE EXTERNAL TABLE IF NOT EXISTS default.vpc_flow_logs ( version int, account string, interfaceid string, sourceaddress string, destinationaddress string, sourceport int, destinationport int, protocol int, numpackets int, numbytes bigint, starttime int, endtime int, action string, logstatus string ) PARTITIONED BY ( dt string ) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' LOCATION 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/' TBLPROPERTIES ("skip.header.line.count"="1");`

### Create Partitions

`ALTER TABLE default.vpc_flow_logs ADD PARTITION (dt='{Year}-{Month}-{Day}') location 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/{Year}/{Month}/{Day}';`

### Analyze Data

`SELECT day_of_week(from_iso8601_timestamp(dt)) AS day, dt, interfaceid, sourceaddress, destinationport, action, protocol FROM vpc_flow_logs WHERE action = 'REJECT' AND protocol = 6 order by sourceaddress LIMIT 100;`

## Solution

Log in to the live AWS environment using the credentials provided.

Once inside the AWS account, make sure you are using  `us-east-1`  (N. Virginia) as the selected region.

### Create CloudWatch Log Group and VPC Flow Logs to CloudWatch and S3

#### Create VPC Flow Log to S3

1.  Navigate to  **VPC**  > **Your

`VPCs**.`

1.  Select the  `A Cloud Guru`  VPC.
2.  At the bottom of the screen, select the  _Flow logs_  tab.
3.  Click  **Create flow log**, and set the following values:
    -   _Filter_:  **All**
    -   _Maximum aggregation interval_:  **1 minute**
    -   _Destination_:  **Send to an Amazon S3 bucket**
    -   _S3 bucket ARN_:
        1.  Navigate to S3 in a new browser tab.
        2.  Select the provided bucket (it should have  `vpcflowlogsbucket`  in its name).
        3.  Click  **Copy ARN**.
        4.  Return to the VPC tab and paste in the value.
            -   This value can also be found on the lab page.
4.  Leave the rest as their defaults and click  **Create flow log**.
5.  Select the  _Flow logs_  tab and verify the flow log shows an  _Active_  status.
6.  In the S3 browser tab, click to open the bucket.
7.  Click the  _Permissions_  tab.
8.  Scroll down to  _Bucket policy_.
9.  Notice the bucket path in the policy includes  **AWSLogs**.
    
    > _Note_: It can take 5–15 minutes before logs appear, so let's move on while we wait for that to happen.
    

#### Create CloudWatch Log Group

1.  In a new browser tab, navigate to  **CloudWatch**  >  **Logs**  >  **Log groups**.
2.  Click  **Create log group**.
3.  In  _Log group name_, enter "VPCFlowLogs".
4.  Click  **Create**.

#### Create VPC Flow Log to CloudWatch

1.  Back in the VPC browser tab, click  **Create flow log**, and set the following values:
    -   _Filter_:  **All**
    -   _Maximum aggregation interval_:  **1 minute**
    -   _Destination_:  **Send to CloudWatch Logs**
    -   _Destination log group_:  **VPCFlowLogs**
    -   _IAM role_: Select the role with  **DeliverVPCFlowLogsRole**  in the name.
2.  Leave the rest as their defaults and click  **Create flow log**.
3.  Under the  _Flow logs_  tab, verify the flow log shows an  _Active_  status.
4.  In the CloudWatch browser tab, click the  `VPCFlowLogs`  log group to open it.
    
    > _Note_: It can take 5–15 minutes before logs start to show up, so let's move on while we wait for that to happen.
    

#### Generate Traffic

1.  In a new browser tab, navigate to  **EC2**.
    
2.  Under  _Resources_  on the EC2 dashboard, select  **Instances (running)**.
    
3.  Select the provisioned  `Web Server`  instance.
    
4.  At the bottom under  _Details_, copy the public IPv4 address to the clipboard.
    
5.  Open a terminal session and log in to the EC2 instance via SSH (the password is provided on the lab page):
    
    `ssh cloud_user@<PUBLIC_IP>`
    
6.  Exit the terminal:
    
    `logout`
    
7.  Return to the EC2 dashboard.
    
8.  With  `Web Server`  selected, click  **Actions**  >  **Security**  >  **Change security groups**.
    
9.  Under  _Associated security groups_, click  **Remove**  to remove the attached security group.
    
10.  In the search bar, search for and select the security group with  `HTTPOnly`  in the name.
    
11.  Click  **Add security group**.
    
12.  Click  **Save**.
    
13.  Return to the terminal and attempt to connect to the EC2 instance again via SSH using the provided lab credentials.
    
    > **Note:**  We expect this connection to time out since we just selected a security group with no SSH access.
    
14.  After about 15 seconds, press  **Ctrl-C**  to cancel the SSH command.
    
15.  Return to the EC2 dashboard.
    
16.  With  `Web Server`  selected, click  **Actions**  >  **Security**  >  **Change security groups**.
    
17.  Under  _Associated security groups_, click  **Remove**  to remove the  `HTTPOnly`  security group.
    
18.  In the search bar, search for and select the security group with  `HTTPAndSSH`  in the name.
    
19.  Click  **Add security group**.
    
20.  Click  **Save**.
    
21.  Attempt to log in to the EC2 instance again via SSH using the credentials provided. This time, it should work.
    
22.  Exit the terminal:
    
    `logout`
    

### Create CloudWatch Filters and Alerts

#### Create CloudWatch Log Metric Filter

1.  Navigate to  **CloudWatch**  >  **Logs**  >  **Log groups**.
    
2.  Select the  `VPCFlowLogs`  log group. You should now see a log stream.
    
    > **Note:**  If you don't see a log stream listed yet, wait a few more minutes and refresh the page until the data appears.
    
3.  Click the listed log stream (it should start with  `eni`).
    
4.  Go back to the  _VPCFlowLogs_  page and select the  **Metric filters**  tab.
    
5.  Click  **Create metric filter**.
    
6.  Enter the following in the  _Filter pattern_  field to track failed SSH attempts on port 22:
    
    `[version, account, eni, source, destination, srcport, destport="22", protocol="6", packets, bytes, windowstart, windowend, action="REJECT", flowlogstatus]`
    
7.  In the  _Select log data to test_  dropdown, select  **Custom log data**.
    
8.  Replace the existing log data with the following:
    
    `2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 22 6 1 40 1563108188 1563108227 REJECT OK 2 086112738802 eni-0d5d75b41f9befe9e 182.68.238.8 172.31.83.158 42227 22 6 1 44 1563109030 1563109067 REJECT OK 2 086112738802 eni-0d5d75b41f9befe9e 42.171.23.181 172.31.83.158 52417 22 6 24 4065 1563191069 1563191121 ACCEPT OK 2 086112738802 eni-0d5d75b41f9befe9e 61.177.172.128 172.31.83.158 39611 80 6 1 40 1563108188 1563108227 REJECT OK`
    
9.  Click  **Test pattern**.
    
10.  Click  **Next**.
    
11.  Set the following values:
    
    -   _Filter name_:  **dest-port-22-rejects**
    -   _Metric namespace_:  **VPC Flow Logs**
    -   _Metric name_:  **SSH-rejects**
    -   _Metric value_:  **1**
12.  Click  **Next**.
    
13.  Click  **Create metric filter**.
    

#### Create Alarm Based on the Metric Filter

1.  Once created, click the checkbox in the top right corner of the metric filter.
2.  Click  **Create alarm**.
3.  In the  _Metric_  section, change  _Period_  to  **1 minute**.
4.  In the  _Conditions_  section, set  _Whenever SSH-rejects is..._  to  **Greater/Equal**  than  **1**.
5.  Click  **Next**.
6.  In the  _Notification_  section, set the following values:
    -   _Select an SNS topic_:  **Create new topic**
    -   _Create a new topic..._: Leave default
    -   _Email endpoints that will receive the notification..._: Enter  **[user@example.com](mailto:user@example.com)**  or your email address
7.  Click  **Create topic**.
8.  Click  **Next**.
9.  In  _Alarm name_, type "SSH Rejects" and click  **Next**.
10.  Click  **Create alarm**.
11.  If you entered your email address earlier, open your email inbox and click the  **Confirm Subscription**  link in the received SNS email.

#### Generate Traffic for Alerts

1.  In the terminal, log in to the  `Web Server`  instance via SSH using the lab credentials.
    
2.  Exit the terminal:
    
    `logout`
    
3.  In a new browser tab, navigate to  **EC2**  >  **Instances(running)**.
    
4.  Select the  `Web Server`  instance.
    
5.  Click  **Actions**  >  **Security**  >  **Change security groups**.
    
6.  Under  _Associated security groups_, click  **Remove**  to remove the attached security group.
    
7.  In the search bar, search for and select the  `HTTPOnly`  security group.
    
8.  Click  **Add security group**.
    
9.  Return to the terminal and attempt to connect to the EC2 instance via SSH.
    
    > **Note:**  We expect this to time out since we just selected a security group with no SSH access.
    
10.  Press  **Ctrl-C**  to cancel the SSH command.
    
11.  Return to EC2.
    
12.  With the  `Web Server`  instance still selected, click  **Actions**  >  **Security**  >  **Change security groups**.
    
13.  Click  **Remove**  to remove the  `HTTPOnly`  security group.
    
14.  Select again the  `HTTPAndSSH`  security group and click  **Add security group**.
    
15.  Click  **Save**.
    
16.  Go back to  **CloudWatch**  >  **Alarms**. We should see our  `SSH Rejects`  alarm enter an  _In alarm_  state shortly.
    
    > **Note:**  If you don't see the alarm listed yet, wait a few more minutes and refresh the page until it appears.
    

### Use CloudWatch Insights

1.  In the left-hand menu, select  **Logs Insights**.
2.  In the  _Select log group(s)_  search bar, select  **VPCFlowLogs**.
3.  In the right-hand pane, select  **Queries**.
4.  Under  _Sample queries_, click  **VPC Flow Logs**  >  **Top 20 source IP addresses with highest number of rejected requests**.
5.  Click  **Apply**.
6.  Observe the query changes.
7.  Click  **Run query**. After a few moments, we'll see some data start to populate.

### Analyze VPC Flow Logs Data in Athena

#### Record Reference Information to Be Used in Athena Queries

> **Note:**  Before attempting to run a query in Athena, you have to specify an S3 bucket for the results to be saved.

1.  In a new browser tab, navigate to S3.
2.  Select the provisioned bucket to open it.
3.  Navigate through the bucket folder structure:  **AWSLogs**  >  **{ACCOUNT_ID}**  >  **vpcflowlogs**  >  **us-east-1**  >  **{YEAR}**  >  **{MONTH}**  >  **{DAY}**.
4.  At the top right, click  **Copy S3 URI**.
5.  Paste the URI into a text file, as we'll need it shortly.

### Create the Athena Table

1.  Navigate to Athena.
    
2.  Click  **Explore the query editor**.
    
3.  Under  **Settings**, click  **Manage**.
    
4.  In  _Location of query result_, paste the S3 bucket path previously copied, making sure it has a forward slash at the end (`s3://{BUCKET_NAME}/AWSLogs/{ACCOUNT_ID}/vpcflowlogs/us-east-1/{YEAR}/{MONTH}/{DAY}/`).
    
5.  Click  **Save**.
    
6.  Under  **Editor**, paste the following DDL code in the  **Query 1**  window, replacing  `{your_log_bucket}`  and  `{account_id}`  with your unique values (you can obtain them from the bucket path you've been using):
    
    `CREATE EXTERNAL TABLE IF NOT EXISTS default.vpc_flow_logs ( version int, account string, interfaceid string, sourceaddress string, destinationaddress string, sourceport int, destinationport int, protocol int, numpackets int, numbytes bigint, starttime int, endtime int, action string, logstatus string ) PARTITIONED BY (dt string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ' ' LOCATION 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/' TBLPROPERTIES ("skip.header.line.count"="1");`
    
7.  Click  **Run**.
    
    -   Once executed, a  `Query successful`  message should display.

#### Create Partitions to Be Able to Read the Data

1.  Click the  `+`  icon to open a new query window.
    
2.  Paste the following code, replacing  `{Year}-{Month}-{Day}`  with today's date and the location with your full S3 bucket location like before:
    
    `ALTER TABLE default.vpc_flow_logs ADD PARTITION (dt='{Year}-{Month}-{Day}') location 's3://{your_log_bucket}/AWSLogs/{account_id}/vpcflowlogs/us-east-1/{Year}/{Month}/{Day}/';`
    
3.  Click  **Run**.
    
    -   A  `Query successful`  message should display.

### Analyze VPC Flow Logs Data in Athena

1.  Open a new query window and paste in the following:
    
    `SELECT day_of_week(from_iso8601_timestamp(dt)) AS day, dt, interfaceid, sourceaddress, destinationport, action, protocol FROM vpc_flow_logs WHERE action = 'REJECT' AND protocol = 6 order by sourceaddress LIMIT 100;`
    
2.  Click  **Run**. Our formatted data should appear underneath.
    

## Conclusion

Congratulations on successfully completing this hands-on lab!
