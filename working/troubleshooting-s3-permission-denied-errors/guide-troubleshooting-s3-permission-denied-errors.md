
# Troubleshooting S3 Permission Denied Errors

## Introduction

In this lab, we'll upload an  `index.html`  file to an S3 bucket that has been provided. We'll enable static web hosting and troubleshoot the configuration to get our website up and running.

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  _us-east-1_  Region.

### Upload  `index.html`  to the S3 Bucket

1.  Open the  [GitHub repository](https://github.com/ACloudGuru/hands-on-aws-troubleshooting/tree/main/Troubleshooting_S3)  and click on the  `index.html`  file.
    
2.  Click  **Raw**  on the right.
    
3.  Copy the URL link to your clipboard.
    
4.  Log in to the AWS Management Console using the  `cloud_user`  credentials.
    
5.  Navigate to S3 by searching for and selecting  **S3**  in the search bar.
    
6.  Look for the bucket prefixed with  **my-website**  created in the us-east-1 Region.
    
7.  In the top-right corner, click on the  **CloudShell**  icon. It may take a moment to initialize.
    
8.  Save the  `indext.html`  file to the working directory in the CloudShell environment:
    
    `curl -O https://raw.githubusercontent.com/ACloudGuru/hands-on-aws-troubleshooting/main/Troubleshooting_S3/index.html`
    
9.  Ensure the file was saved:
    
    `ls`
    
10.  Retrieve the S3 bucket name:
    
    `aws s3 ls`
    
11.  Copy the  `indext.html`  file to the S3 bucket:
    
    `aws s3 cp index.html s3://<BUCKET_NAME>`
    

### Enable Static Web Hosting

1.  From the S3 Management Console, select the  **my-website**  bucket.
2.  Navigate to the  **Properties**  tab.
3.  Scroll down until you see  **Static website hosting**.
    -   Click  **Edit**.
    -   Under  **Static website hosting**, select  **Enable**.
    -   Under  **Index document**, enter  _index.html_.
4.  Sroll down and click  **Save changes**.
5.  Scroll down to  **Static website hosting**  and copy the  **Bucket website endpoint**  URL.
6.  Paste the URL in a new browser. You will see a  `403 Forbidden`  error.

### Troubleshoot the Configuration

1.  Navigate back to your bucket and select the  **Permissions**  tab.
2.  Scroll down to  **Block public access (bucket settings)**  and click  **Edit**.
3.  Deselect  **Block  _all_  public access**.
4.  Click  **Save changes**.
5.  Enter  _confirm_  in the pop-up window to finalize the edit, then click  **Confirm**.
6.  Navigate back to the web page and refresh the page. You will still see a  `403 Forbidden`  error.

#### A Troubleshooting Clue

1.  Navigate back to the S3 buckets page by selecting  **Buckets**  in the navigation bar at the top.
2.  Review the  **Access**  setting for the bucket. It should read  **Objects can be public**.

#### The Final Fix

1.  Select the  **my-website**  bucket.
    
2.  Navigate to the  **Permissions**  tab.
    
3.  Scroll down to  **Bucket policy**  and select  **Edit**.
    
4.  Remove the old policy and replace it with the following policy. Make sure to replace  `<MY_BUCKET_ARN>`  with your bucket ARN (listed above the  **Policy**  title)  **Note:**  make sure you leave the  `/*`  after the bucket ARN:
    
    `{ "Version": "2012-10-17", "Id": "Policy1645724938586", "Statement": [ { "Sid": "Stmt1645724933619", "Effect": "Allow", "Principal": "*", "Action": "s3:GetObject", "Resource": "<MY_BUCKET_ARN>/*" } ] }`
    
5.  Scroll down and click  **Save changes**.
    
6.  You should now see a  **Publicly accessible**  tag under the bucket name.
    
7.  Navigate back to the web page and refresh the page. The website should now be accessible.
    

## Conclusion

Congratulations — you've completed this hands-on lab!
