
# Configuring Amazon S3 Buckets to Host a Static Website with a Custom Domain

## Introduction

In this live AWS environment, we will create and configure a simple static website. Then, we will configure that static website with a custom domain, using Route 53  `Alias`  record sets. This lab demonstrates how to create cost-efficient website hosting for sites that consist of files like HTML, CSS, JavaScript, fonts, and images.

The code we use for the static site is  [here](https://github.com/ACloudGuru-Resources/aws-s3-route53-static-website/tree/main).

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (us-east-1) region throughout the lab.

### Create an S3 Bucket and a Static Website

#### Create an S3 Bucket

1.  Use the  _Services_  menu to navigate to  _Route 53_.
2.  On the  _Route 53_  dashboard, select the  _Hosted zone_  link. There is one domain name assigned to us for this lab, which we'll use to set up our static website.
3.  In a new browser tab, open the GitHub repository provided for the lab. This is where we'll download the HTML files we'll need to upload to our S3 bucket.
4.  Click the green  **Code**  dropdown and select  **Download ZIP**, then extract all files.
5.  Navigate back to the  _Hosted zones_  tab and select the domain name link, then copy the domain name. We each have a unique domain name configured for the lab.
6.  Use the  _Services_  menu to navigate to  _S3_, then click  **Create bucket**.
7.  Create a new S3 bucket:
    -   In the  _Bucket name_  field, paste your copied domain name. Your bucket name must match your domain name exactly when setting up a static website using  _S3_  and  _Route 53_.
    -   Ensure the  _Region_  is set to  **US East (N. Virginia) us-east-1**.
    -   In  _Object Ownership_, check  **ACLs enabled**.
    -   In  _Bucket settings for Block Public Access_, uncheck the  **Block  _all_  public access**  checkbox.
    -   In the warning box, check  **I acknowledge that the current settings might result in this bucket and the objects within becoming public**.
    -   In  _Object Ownership_, check the  **ACLs enabled**  option with  **Bucket owner preferred**.
    -   Leave all other default settings and click  **Create bucket**. The bucket is created and the bucket's access shows objects can be public.

#### Create a Static Website

1.  On the  _Buckets_  page, select the domain name link. In the  _Objects_  section, click  **Upload**.
2.  On the  _Upload_  page, click  **Add files**  and navigate to the  _penguinsite_  folder in your extracted GitHub resources. This is where the HTML files are stored.
3.  Select all the HTML files and click  **Open**  to add them to the domain files in AWS.
4.  Leave all other default settings and click  **Upload**.
5.  After the confirmation message displays, select the  _Destination_  link to open the main page of the S3 bucket.
6.  Select the  **Properties**  tab, then scroll down to  _Static website hosting_  and click  **Edit**.
7.  Set the hosting properties:
    -   Select  **Enable**  to enable static website hosting, then ensure the  _Hosting type_  is set to  **Host to a static website**.
    -   Below  _Index document_, enter  `index.html`, and below  _Error document_, enter  `error.html`.
    -   Click  **Save changes**.
8.  On the  _Properties_  tab, scroll back down to  _Static website hosting_  and select the  _Bucket website endpoint_  link. We should receive an  _access denied_  error, which indicates either that there is an error within our S3 bucket or our HTML files are not public.
9.  Go back to the  _Objects_  tab and select all the HTML files.
10.  Use the  **Actions**  dropdown to select  **Make public via ACL**, then click  **Make public**  again to confirm.
11.  After the confirmation message displays, go back to the S3 bucket and check the  _Properties_  tab again. When you select the  _Bucket website endpoint_, your static website should open.

#### Configure a DNS Record for the S3 Bucket

1.  Navigate to  _Route 53_  so we can create an  _A name_, or alias record.
2.  Select the  _Hosted zone_  link, then select the domain name.
3.  Click  **Create record**  and select  **Switch to wizard**.
4.  On the  _Choose routing policy page_, select  **Simple routing**  and click  **Next**.
5.  On the  _Configure records_  page, click  **Define simple record**.
6.  In the  _Value/Route traffic to_  section, configure the record settings:
    -   Use the  _Choose endpoint_  dropdown to select  **Alias to S3 website endpoint**.
    -   Use the  _Choose Region_  dropdown to select  **US East (N. Virginia) [us-east-1]**.
    -   Click into the  _Choose S3 bucket_  field and select the bucket you created. The bucket name should display automatically.
    -   Leave all other default settings and click  **Define simple record**.
7.  After the record is defined, click  **Create records**. The type  _A_  record is created and can route files from the bucket to the website.
8.  In the  _Records_  section, copy the bucket name and paste it into a browser to test the alias record. The alias should display the website (it may take up to 20 minutes for your DNS propagation).

### Configure a Custom Domain in Route 53

#### Create a Redirect S3 Bucket

1.  Navigate to  _S3_  and copy your existing static bucket name, then click  **Create bucket**.
2.  Create a redirect S3 bucket:
    -   In the  _Bucket name_  field, type "[www](http://www/)."  and paste your copied bucket name.
    -   Ensure the  _Region_  is set to  **US East (N. Virginia) us-east-1**.
    -   In  _Bucket settings for Block Public Access_, uncheck the  **Block  _all_  public access**  checkbox.
    -   In the warning box, check  **I acknowledge that the current settings might result in this bucket and the objects within becoming public**.
    -   Leave all other default settings and click  **Create bucket**. The bucket is created and the bucket's access shows objects can be public.
3.  Select the domain name link for the new redirect bucket, then copy the redirect domain name.
4.  Select the  **Properties**  tab, then scroll down to  _Static website hosting_  and click  **Edit**.
5.  Set the redirect hosting properties:
    -   Select  **Enable**  to enable static website hosting, then ensure the  _Hosting type_  is set to  **Redirect requests for an object**.
    -   In the  _Host name_  field, paste the static domain name.
    -   Click  **Save changes**.

#### Configure a DNS Record for the Redirect S3 Bucket

1.  Navigate to  _Route 53_  so we can create an  _A name_, or alias record, for the redirect bucket.
2.  Select the  _Hosted zone_  link, then select the domain name.
3.  Click  **Create record**  and select  **Switch to wizard**.
4.  On the  _Choose routing policy_  page, select  **Simple routing**  and click  **Next**.
5.  On the  _Configure records_  page, click  **Define simple record**.
6.  In the  _Value/Route traffic to_  section, configure the record settings:
    -   In the  _Record name_  field, enter  `www`.
    -   Set the same endpoint and region as the static bucket.
    -   Click into the  _Choose S3 bucket_  field and select the redirect bucket you created. The bucket name should display automatically.
    -   Leave all other default settings and click  **Define simple record**.
7.  After the record is defined, click  **Create records**.
8.  In the  _Records_  section, copy the redirect bucket name and paste it into a browser to test the alias record. The alias should display the website (this may take a few moments).

### Test the Static Website with  `dig`  and  `nslookup`

1.  Open the instant terminal provided for the lab.
2.  To verify the website is properly routed, run the command:
    
    `dig <DOMAIN NAME> NS`
    
3.  For troubleshooting, run the command:
    
    `nslookup <DOMAIN NAME>`
    

You know the website is properly routed if the route traffic for the name server (NS) record in  _Route 53_  matches the  _Answer Section_  data in the terminal.

## Conclusion

Congratulations — you've completed this hands-on lab!
