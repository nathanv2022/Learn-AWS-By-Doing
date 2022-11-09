# AWS Security Essentials - KMS Integration with S3

## Introduction

AWS Key Management Service (KMS) is a managed service that makes it easy for you to create and control the encryption keys used to encrypt your data. KMS uses FIPS 140-2 validated hardware security modules to protect the security of your keys. AWS Key Management Service is integrated with most other AWS services to help you protect the data you store with these services. AWS Key Management Service is also integrated with AWS CloudTrail and S3 to provide you with logs of all key usage to help meet your regulatory and compliance needs.

This activity allows the student to get experience with how KMS integrates with services in AWS while encrypting S3 data with a default master key as well as a custom key.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Create an Encrypted S3 Bucket

1.  From the AWS Management Console, click  **Services**.
2.  Under  _Storage_, click  **S3**.
3.  Click  **Create Bucket**.
4.  In  _Bucket name_, set a unique bucket name.
5.  Scroll down to  _Default encryption_  and click  **Enable**.
6.  In  _Encryption key type_, select  **AWS Key Management Service key (SSE-KMS)**.
7.  In  _AWS KMS key_, leave it as the default and click  **Create bucket**.

### Upload a File to the Encrypted S3 Bucket

1.  Click the newly created bucket to open it.
2.  To the right, click  **Upload**.
3.  Click  **Add files**.
4.  Select a file from your local machine to upload and click  **Choose for Upload**.
5.  Click  **Upload**.
6.  Once the upload has succeeded, click  **Exit**.
7.  To confirm that the file was successfully encrypted, click the file to open it.
8.  Scroll down to  _Server-side encryption settings_. Notice that in  _KMS master key ARN_, a master key ARN number has been created to encrypt the file from the S3 bucket.

### Encrypt Two Files in S3 with Different Keys

#### Create a Customer Managed Key

1.  On the top main menu, click  **Services**  and select  **Key Management Service**.
2.  On the left menu, select  **Customer managed keys**.
3.  Click  **Create key**.
4.  Click  **Next**.
5.  In  _Alias_, enter "my_s3_key".
6.  Click  **Next**  >  **Next**  >  **Next**.
7.  Click  **Finish**.

#### Upload a New File and Encrypt with the Customer Managed Key

1.  Return to S3 and click the bucket to open it.
2.  To the right, click  **Upload**.
3.  Click  **Add files**.
4.  Select a new file from your local machine to upload and click  **Choose for Upload**.
5.  Click  **Upload**.
6.  Click  **Properties**  and scroll down to  _Server-side encryption settings_.
7.  In  _Encryption settings_, select  **Override default encryption bucket settings**.
8.  In  _Encryption key type_, select  **AWS Key Management Service key (SSE-KMS)**.
9.  In  _AWS KMS Key_, select  **Choose from your KMS master keys**.
10.  In  _KMS master key_, select the customer managed key previously created.
11.  Scroll to the bottom and click  **Upload**.
12.  Once the upload has succeeded, click  **Exit**.
13.  To confirm that the file was successfully encrypted by the custom key, click the file to open it.
14.  Scroll down to  _Server-side encryption settings_. Notice that in  _KMS master key ARN_, a new master key ARN number has been created to override the S3 bucket policy.

> **Note:**  S3 bucket encryption policies override the settings of the folders within them. If you need to use separate encryption keys for some documents within a bucket, you will need to change the settings on each document individually.

## Conclusion

Congratulations — you've completed this hands-on lab!
