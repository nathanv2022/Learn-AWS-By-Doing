# Creating a Basic Amazon S3 Lifecycle Policy

## Introduction

AWS Glacier is a long-term archive storage service that provides lower-cost storage than other AWS storage options. When data has not been accessed for a certain period of time, it can be moved automatically between S3 storage classes using a lifecycle policy. In this lab, we will create a basic Amazon S3 lifecycle policy.

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  `us-east-1`  region.

[Download the ccp-master folder](https://github.com/tia-la/ccp)  to upload to the S3 bucket we create.

### Create an S3 Bucket and Upload an Object

1.  Navigate to S3.
2.  Click  **Create bucket**.
3.  In  _Bucket name_, enter a globally unique name.
4.  Deselect  _Block all public access_.
5.  Click  **I acknowledge that the current settings might result in the bucket and the objects within becoming public**.
6.  Click  **Create bucket**.
7.  Click the bucket to open it and click  **Upload**.
8.  Click  **Add folder**.
9.  Select the  `ccp-master`  folder downloaded from  [GitHub](https://github.com/tia-la/ccp).
10.  Click  **Upload**  >  **Upload**.
11.  At the bottom of the page, click  **Upload**.

### Create a Lifecycle Policy

1.  Return to the main page of the S3 bucket.
2.  Select the  **Management**  tab.
3.  Scroll to  _Lifecycle rules_  and click  **Create lifecycle rule**.
4.  In  _Lifecycle rule name_, enter "sample-s3-to-glacier-rule".
5.  Scroll to  _Filter type_  and in  _Prefix_  enter "pinehead".
6.  In  _Lifecycle rule actions_, click  **Transition current versions of objects between storage classes**  and  **Transition previous versions of objects between storage classes**.
7.  In  _Transition current versions of objects between storage classes_, select  **Glacier**  from the dropdown and set  _Days after object creation_  to "30".
8.  Click  **I acknowledge that this lifecycle rule will increase the one-time lifecycle request cost if it transitions small objects.**
9.  In  _Transition previous versions of objects between storage classes_, select  **Glacier Deep Archive**  from the dropdown and set  _Days after objects become noncurrent_  to "15".
10.  Click  **I acknowledge that this lifecycle rule will increase the one-time lifecycle request cost if it transitions small objects.**
11.  Click  **Create rule**.

## Conclusion

Congratulations — you've completed this hands-on lab!
