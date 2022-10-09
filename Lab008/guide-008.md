
# Creating Amazon S3 Buckets, Managing Objects, and Enabling Versioning

## Learning Objectives
### 1. Create a Public and Private Amazon S3 Bucket
- Create two S3 buckets. One bucket should be a private bucket named  `acg-testlab-private-<random>`. The other should be a public bucket named  `acg-testlab-public-<random>`. The public bucket should have public access unblocked.

- Upload the file  `cat1.jpg`  found in the lab files to both S3 buckets, and test whether you can access them

### 2. Enable Versioning on the Public Bucket and Validate Access to Different Versions of Files with the Same Name

- Enable versioning the public bucket. Rename the image originally named  `cat2.jpg`  to  `cat1.jpg`, and upload it to the public S3 bucket, which will be created as a new version of the original file. Using the URLs for the different versions of the image, confirm that you can access both images.

## Introduction

In this hands-on lab, we will create two S3 buckets and verify public vs. non-public access to the buckets. We will also enable and validate versioning based on uploaded objects.

## Solution

Log in to the AWS Management Console using the provided credentials, and make sure you are in the  `us-east-1`  region.

Download the files needed for the lab here:  [https://github.com/ACloudGuru-Resources/S3BucketsLabFiles/](https://github.com/ACloudGuru-Resources/S3BucketsLabFiles).

To upload the  `cat2.jpg`  file when you're testing versioning, you will need to rename it to  `cat1.jpg`  to achieve the same results as the hands-on lab video.

### Create a Public and Private Amazon S3 Bucket

#### Create a Public Bucket

1.  Navigate to S3.
2.  Click  **Create bucket**.
3.  Set the following values:
    -   **Bucket name**: Enter  `acg-testlab-public-<random>`, where  `<random>`  is a random string of characters to make the bucket name globally unique (e.g.,  `acg-testlab-4324yr-public`).
    -   **Region**: Select  **US East (N. Virginia) us-east-1**.
    -   **Object Ownership**: Select  **ACLs enabled**  and  **Bucket owner preferred**.
4.  In the  **Block Public Access settings for this bucket**  section, uncheck the box for  **Block  _all_  public access**.
5.  Check the box stating  **I acknowledge that the current settings might result in this bucket and the objects within becoming public**  to confirm that we understand the bucket is going to be public
6.  Leave the rest of the settings as their defaults.
7.  Click  **Create bucket**.

#### Create a Private Bucket

1.  On the  **Buckets**  screen, click  **Create bucket**.
2.  Set the following values:
    -   **Bucket name**: Enter  `acg-testlab-private-<random>`, where  `<random>`  is a random string of characters to make the bucket name globally unique (you can use the same string from your public bucket).
    -   **Region**: Select  **US East (N. Virginia) us-east-1**.
3.  Leave the rest of the settings as their defaults.
4.  Click  **Create bucket**.

#### Upload a File in the Private Bucket

1.  Select the private bucket name to open it.
2.  In the  **Objects**  section, click  **Upload**.
3.  Click  **Add files**.
4.  Navigate to the files you downloaded for the lab, and upload the  `cat1.jpg`  image.
5.  Leave the rest of the settings on the page as their defaults.
6.  Click  **Upload**.
7.  After the file uploads successfully, click its name to view its properties.
8.  Open the  **Object URL**  in a new browser tab. Since it's a private bucket, you'll see an error message.
9.  Back on the  **cat1.jpg**  page, select the  **Object actions**  dropdown.
10.  Note that the  **Make public using ACL**  option is grayed out, because the bucket is private and we set the ownership to not use ACLs.

#### Upload a File in the Public Bucket

1.  Click  **Buckets**  in the link trail at the top.
2.  Select the public bucket name to open it.
3.  In the  **Objects**  section, click  **Upload**.
4.  Click  **Add files**.
5.  Navigate to the files you downloaded for the lab, and upload the  `cat1.jpg`  image.
6.  Leave the rest of the settings on the page as their defaults.
7.  Click  **Upload**.
8.  After the file uploads successfully, click its name to view its properties.
9.  Open the  **Object URL**  in a new browser tab. You should receive an error message because although the bucket is public, the object is not.
10.  Back on the  **cat1.jpg**  page, select  **Object actions**  >  **Make public using ACL**.
11.  Click  **Make public**.
12.  Open the  **Object URL**  in a new browser tab again. This time, the image should load.

### Enable Versioning on the Public Bucket and Validate Access to Different Versions of Files with the Same Name

#### Enable Versioning

1.  Back on the public bucket page, click the  **Properties**  tab.
2.  In the  **Bucket Versioning**  section, click  **Edit**.
3.  Click  **Enable**  to enable bucket versioning.
4.  Click  **Save changes**.

#### Upload Another Image to Test Versioning

1.  Click the  **Objects**  tab.
2.  Click  **Upload**, and then click  **Add files**.
3.  Rename  `cat2.jpg`  to  `cat1.jpg`  (this way, you'll upload a different image than the original  `cat1.jpg`  image).
4.  Upload the newly renamed  `cat1.jpg`  image.
5.  Click  **Upload**.
6.  After the file uploads successfully, click its name to view its properties.
7.  Click the  **Versions**  tab. You should see there are two versions of the  `cat1.jpg`  file.

#### View the Image Versions

1.  Select  **Object actions**  >  **Make public using ACL**.
2.  Click  **Make public**.
3.  Click the  **Properties**  tab.
4.  Open the  **Object URL**  in a new browser tab. This time, you should see the new image.
5.  Back on the  **cat1.jpg**  page, click the  **Versions**  tab.
6.  Click the  **null**  object.
7.  Open its  **Object URL**  in a new browser tab. You should see the original  `cat1.jpg`  image you uploaded.

## Conclusion
Congratulations on successfully completing this hands-on lab!

## Delete created resources
- Delete objects in each bucket or use function 'emply bucket'
- Delete buckets
