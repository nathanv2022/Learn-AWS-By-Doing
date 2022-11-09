
# Monitoring, Auditing, and Logging Users and Resource Usage in AWS IAM


## Description

In this hands-on lab scenario, you are a security engineer working for a new startup that's launching an online bookstore for rare and antique books. The founder, Kia, needs your help with monitoring and auditing the activities in her account. In order to provide access and ensure the proper security measures are in place, you will use AWS Identity & Access Management (IAM) and AWS CloudTrail. You will provide Kia with the credential report, the details from the Access Advisor tab, and you will create a trail using CloudTrail.

## Objectives

Successfully complete this lab by achieving the following learning objectives:

### Generate a Credential Report

1.  Log in to the AWS Management Console.
2.  Access Identity & Access Management (IAM).
3.  Click  **Credential Report**.
4.  Download the report and open it.

### Utilize the Access Advisor Tab

1.  Log in to the AWS Management Console.
2.  Access Identity & Access Management (IAM).
3.  Access the  `developer-1`  user.
4.  Review the details of the Access Advisor tab.

### Create a Trail using CloudTrail

1.  Log in to the AWS Management Console.
2.  Access CloudTrail.
3.  Review the event history for the account.
4.  Create a trail that logs to an Amazon S3 bucket.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Generate a Credential Report

1.  Navigate to the IAM dashboard.
2.  From the left menu, click  **Credential report**.
3.  Click  **Download Report**  and open the downloaded CSV file.  _(NOTE: This file can be viewed using Excel or Numbers.)_

### Utilize the Access Advisor Tab

1.  Navigate back to the IAM Dashboard.
2.  From the left menu, click  **Users**.
3.  Click on  **developer-1**  user.
4.  Click the  **Access Advisor**  tab to review allowed services for the user.

### Create a Trail using CloudTrail

1.  Navigate back to the AWS Management Console for  **CloudTrail**.
2.  On the left menu, click  **Event history**  to review the event history for the account.
3.  There are 2 ways to create trails, on the left menu, click  **Dashboard**  >  **Create trail**  or  **CloudTrail**  >  **Create a trail**.
4.  On the  _Choose trail attributes_  page, set the following values:
    -   _Trail name_: "lab-trail"
    -   _Storage location_: Create new S3 bucket
    -   _Trail log bucket and folder_: default bucket name
    -   _Log file SSE-KMS encryption_: Deselect  **Enabled**
    -   _Log file validation_: Deselect  **Enabled**
    -   _CloudWatch Logs_: Deselect  **Enabled**
5.  Click  **Next**.
6.  On the  _Choose log events_  page, select  _Management events_,  _Data events_, and  _Insights events_.
7.  In the  _Management events_  section, select  _Read_  and  _Write_.
8.  In  _Data events_  section, set the following vales:
    -   _Data event: S3_: select  _Read_  and  _Write_.
    -   _Data event: Lambda_:  _All regions_  and  _All functions_
9.  In the  _Insights events_  section: select  _API call rate_.
10.  Click  **Next**.
11.  Review the trail and click  **Create trail**.

## Conclusion

Congratulations — you've completed this hands-on lab!
