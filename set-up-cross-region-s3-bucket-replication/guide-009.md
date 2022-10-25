
# Set Up Cross-Region S3 Bucket Replication

## Objectives
### Create an S3 Bucket and Enable Replication

1.  Copy the name of the lab-provided  `*appconfigprod1*`  bucket and use it to create a new S3 bucket in the US West (Oregon)  `us-west-2`  region, replacing  `*appconfigprod1*`  with  `*appconfigprod2*`  to ensure it is globally unique.

> **Note:**  After creating the new bucket, you may receive a warning about system tags; you can safely ignore it.

2.  Enable automatic file replication from the  `*appconfigprod1*`  S3 bucket to the  `*appconfigprod2*`  S3 bucket.

### Test Replication and Observe Results

1.  Upload a file to the  `*appconfigprod1*`  S3 bucket.
2.  Ensure the file was automatically replicated to the  `*appconfigprod2*`  S3 bucket.


## Introduction

Amazon Simple Storage Service (Amazon S3) is an object storage service that offers industry-leading scalability, data availability, security, and performance. In this lab, we explore how to use Amazon S3 to automatically replicate any object stored in our S3 bucket to a different region on the other side of the country. This ensures our files remain accessible in any extreme scenario where data loss could possibly occur. By the end of this lab, the user will understand how to create S3 buckets and enable automatic replication to back up files in a different physical location.


## Solution

Log in to the live AWS environment using the credentials provided. Use an incognito or private browser window to ensure you're using the lab account rather than your own.

Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Create an S3 Bucket and Enable Replication

1.  In the AWS console, navigate to S3.
2.  Copy the name of the lab-provided  `appconfigprod1`  bucket.
3.  Click  **Create bucket**.
4.  Set the following values:
    -   **Bucket name**: Paste the name you copied, but replace  `appconfigprod1`  with  `appconfigprod2`.
    -   **AWS Region**: Select  **US West (Oregon) us-west-2**.
5.  Under  **Copy settings from existing bucket**, click  **Choose bucket**.
6.  Select the  `appconfigprod1`  bucket.
7.  Click  **Choose bucket**.
8.  Leave the rest of the settings as the defaults, and click  **Create bucket**. If you receive a warning about system tags, you can safely ignore it.
9.  Click the  `appconfigprod1`  bucket to open it.
10.  Click the  **Management**  tab.
11.  In the  **Replication rules**  section, click  **Create replication rule**.
12.  Click  **Enable Bucket Versioning**.
13.  Set the following values:
    -   Under  **Replication rule configuration**, in  **Replication rule name**, enter  _CrossRegion_.
    -   Under  **Source bucket**, in  **Choose a rule scope**, select  **Apply to all objects in the bucket**.
    -   Under  **Destination**, set the following parameters:
        1.  Leave  **Choose a bucket in this account**  selected.
        2.  Click  **Browse S3**.
        3.  Select the  `appconfigprod2`  bucket.
        4.  Click  **Choose path**.
        5.  Click  **Enable bucket versioning**.
    -   Under  **IAM role**, click the dropdown menu under  **IAM role**, and select  **Create new role**.
14.  Click  **Save**.
15.  When prompted with the  **Replicate existing objects?**  popup, choose  **No, do not replicate existing objects**  and click  **Submit**.

### Test Replication and Observe Results

1.  Click the  `appconfigprod1`  bucket link in the breadcrumb trail navigation at the top of the screen.
2.  Click  **Upload**.
3.  Either drag a file to the window or click  **Add file**  to upload a file of your choice.
4.  Click  **Upload**.
5.  Once the upload has succeeded, click  **Close**  in the top-right corner.
6.  Click the  **Buckets**  link in the breadcrumb trail navigation at the top of the page.
7.  Click the  `appconfigprod2`  bucket to open it.
    -   You should see the file you uploaded to  `appconfigprod1`. If it isn't there yet, refresh and wait a minute or two for it to appear.

## Conclusion

Congratulations on successfully completing this hands-on lab!
