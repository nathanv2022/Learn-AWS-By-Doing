# Create a Static Website Using Amazon S3

## Objectives
### 1. Create S3 Bucket

Create an S3 bucket that begins with the name  `my-bucket`  (e.g.,  `my-bucket-<ACCOUNT ID>`) in the  `us-east-1`  region. When creating the bucket, remember to uncheck the S3 Block Public Access settings. Upload the  [code for the static site](https://github.com/ACloudGuru-Resources/Course-Certified-Solutions-Architect-Associate/tree/master/labs/creating-a-static-website-using-amazon-s3). You will find the code (`index.html`  and  `error.html`) in the following GitHub repository:  **[https://github.com/ACloudGuru-Resources/Course-Certified-Solutions-Architect-Associate/tree/master/labs/creating-a-static-website-using-amazon-s3](https://github.com/ACloudGuru-Resources/Course-Certified-Solutions-Architect-Associate/tree/master/labs/creating-a-static-website-using-amazon-s3)**

### 2. Enable Static Website Hosting

You can use Amazon S3 to host a static website. On a static website, individual web pages include static content. They might also contain client-side scripts.

To host a static website on Amazon S3, configure an Amazon S3 bucket for website hosting, and then upload your website content to the bucket.

When you configure a bucket as a static website, you must enable website hosting, set permissions, and create and add an index document.

**You must ensure that the S3 Block Public Access settings are disabled on the bucket, so that the files in the bucket can be made publicly readable.**

### 3. Apply Bucket Policy

To make objects in your bucket publicly readable, write a bucket policy that grants everyone  `s3:GetObject`  permission.

Note that AWS will not permit you to create the policy if the S3 Block Public Access settings are still enabled on the bucket.

After disabling the Block Public Access settings, you can add a bucket policy to grant public read access to your bucket. When you grant public read access, anyone on the internet can access your bucket.


## Introduction

In this AWS hands-on lab, we will create and configure a simple static website. We will go through configuring that static website with a custom error page. This will demonstrate how to create a cost-efficient website hosting for sites that consist of files like HTML, CSS, JavaScript, fonts, and images.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Create S3 Bucket

1.  In a new browser tab, navigate to the  [GitHub repository for the code](https://github.com/ACloudGuru-Resources/Course-Certified-Solutions-Architect-Associate/tree/master/labs/creating-a-static-website-using-amazon-s3).
    
2.  Select the  `error.html`  file.
    
3.  Above the code area, click  **Raw**.
    
4.  Right-click and select  **Save Page As**, and save the file as  **error.html**.
    
    > **Note**: If you are using Safari as your web browser, ensure you remove  `.txt`  from the end of the filename. Also, ensure the  **Format**  is  **Page Source**. When asked whether you want to save the file as plain text, click  **Don't append**.
    
5.  Repeat this for the  `index.html`  file.
    
6.  In the AWS Management Console, navigate to S3.
    
7.  Click  **Create bucket**.
    
8.  Set the following values:
    
    -   **Bucket name**:  _my-bucket-_  with the AWS account ID or another series of numbers at the end to make it globally unique
    -   **Region**:  _US East (N. Virginia) us-east-1_
9.  In the  **Block Public Access settings for this bucket**  section, un-check  **Block all public access**.
    
    -   Ensure all four permissions restrictions beneath it are also un-checked.
10.  Check the box to acknowledge that turning off all public access might result in the bucket and its objects becoming public.
    
11.  Leave the rest of the settings as their defaults.
    
12.  Click  **Create bucket**.
    
13.  Click the radio button next to the bucket name to select it.
    
14.  Click  **Copy ARN**  and paste it into a plaintext file, as you'll need it later.
    
15.  Click the bucket name.
    
16.  Click  **Upload**.
    
17.  Click  **Add files**, and upload the  `error.html`  and  `index.html`  files you previously saved from GitHub.
    
18.  Leave the rest of the settings as their defaults.
    
19.  Click  **Upload**.
    
20.  Click  **Close**  in the upper right.
    

### Enable Static Website Hosting

1.  Click the  **Properties**  tab.
    
2.  Scroll to the bottom of the screen to find the  **Static website hosting**  section.
    
3.  On the right in the  **Static website hosting**  section, click  **Edit**.
    
4.  On the  **Edit static website hosting**  page, set the following values:
    
    -   **Static website hosting**:  _Enable_
    -   **Hosting type**:  _Host a static website_
    -   **Index document**:  _index.html_
    -   **Error document**:  _error.html_
5.  Click  **Save changes**.
    
6.  In the  **Static website hosting**  section, open the listed endpoint URL in a new browser tab. You'll see a  `403 Forbidden`  error message.
    

### Apply Bucket Policy

1.  Back in S3, click the  **Permissions**  tab.
    
2.  In the  **Bucket policy**  section, click  **Edit**.
    
3.  In the  **Policy**  box, enter the following JSON statement (replacing  `<BUCKET_ARN>`  with the one you copied earlier):
    
    `{ "Version": "2012-10-17", "Id": "Policy1645724938586", "Statement": [ { "Sid": "Stmt1645724933619", "Effect": "Allow", "Principal": "*", "Action": "s3:GetObject", "Resource": "<BUCKET_ARN>/*" } ] }`
    
    > **Note:**  Ensure the trailing  `/*`  is present so the policy applies to all objects within the bucket.
    
4.  Click  **Save changes**.
    
5.  Refresh the browser tab with the static website (the endpoint URL you opened earlier). This time, the site should load correctly.
    
6.  Add a  `/`  at the end of the URL and some random letters (anything that's knowingly an error). This will display your  `error.html`  page.
    

## Conclusion

Congratulations — you've completed this hands-on lab!
