
# Building a CI/CD Pipeline with AWS CodePipeline to Deploy a Static Website on S3

## Introduction

AWS CodePipeline provides a native AWS continuous deployment pipeline to manage web application deployments from the source code repository to the deployment of our web application.

In this lab, we will walk through setting up AWS CodePipeline to continuously deploy our web application to S3. We will walk through the prerequisites to set up our pipeline by setting up our source code repository with AWS CodeCommit and creating an S3 bucket to host static web applications. Finally, we will set up our continuous code pipeline with AWS CodePipeline and deploy our web application to S3.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

Please find the  `index.html`  and  `Mount.jpg`  files used for this lab in the  [GitHub repository](https://github.com/natonic/Developer-Tools-Deep-Dive/tree/master/Labs/PipelineToStaticS3).

### Create a CodeCommit Repository from the Management Console

1.  Navigate to CodeCommit.
2.  Under  _Repositories_, click  **Create repository**.
3.  In  _Repository name_, enter "sample-static-site".
4.  Under  _Tags_, click  **Add**.
5.  Set the following values:
    -   _Key:_  **CreatedBy**
    -   _Value:_  Your name
6.  Click  **Create**.

#### Add an  `index.html`  and JPG File to the Repository

1.  Scroll to the bottom of the page and click  **Add file > Upload file**.
2.  Click  **Choose file**  and select the  `index.html`  file downloaded from  [GitHub](https://github.com/natonic/Developer-Tools-Deep-Dive/tree/master/Labs/PipelineToStaticS3).
3.  In  _Commit changes to master_, set the following values:
    -   _Author name_: Your name
    -   _Email address_: Your email
    -   _Commit message_:  **Landing page**
4.  Click  **Commit changes**.
5.  Click  **Repositories**.
6.  Click  **sample-static-site**  to open the repository page.
7.  Click  **Add file**  >  **Upload file**.
8.  Click  **Choose file**  and select the  `Mount.jpg`  file downloaded from  [GitHub](https://github.com/natonic/Developer-Tools-Deep-Dive/tree/master/Labs/PipelineToStaticS3).
9.  In the  _Commit changes to master_  section, set the following values:
    -   _Author name_: Your name
    -   _Email address_: Your email
    -   _Commit message:_  **Photo**
10.  Click  **Commit changes**.

### Create an S3 Bucket and Configure It To Host a Static Website

#### Create an S3 Bucket

1.  Navigate to S3.
2.  Click  **Create bucket**.
3.  Set the following values:
    -   _Bucket name:_  Unique bucket name
    -   _Region:_  **US East (N. Virginia)**
4.  Click  **Next**  >  **Next**.
5.  Deselect  **Block all public access**.
6.  Select  **I acknowledge that the current settings might result in this bucket and the objects within becoming public**.
7.  Click  **Add tag**.
8.  Set the following values:
    -   _Key:_  **CreatedBy**
    -   _Value:_  Your name
9.  Leave the rest as their defaults and click  **Create bucket**.

#### Enable Static Website Hosting

1.  Click the newly created bucket to open it and select the  _Properties_  tab.
2.  Scroll to  _Static website hosting_  at the bottom and click  **Edit**.
3.  In  _Static website hosting_, select  **Enable**.
4.  Set the following values:
    -   _Index document:_  **Index.html**
    -   _Error document:_  **error.html**
5.  Click  **Save changes**.

#### Create an S3 Bucket Policy

1.  Select the  _Permissions_  tab.
2.  Scroll down to  _Bucket policy_  and click  **Edit**.
3.  Copy the bucket ARN number above the policy editor.
4.  Click  **Policy Generator**.
5.  In  _Select Type of Policy_, select  **S3 Bucket Policy**.
6.  In  _Add Statement(s)_, set the following values:
    -   _Effect:_  **Allow**
    -   _Principal:_  *
    -   _AWS Service:_  **Amazon S3**
    -   _Actions:_  **GetObject**
    -   _Amazon Resource Name (ARN):_  **<BUCKET_ARN_NUMBER>/***
7.  Click  **Add Statement**.
8.  Click  **Generate Policy**.
9.  Copy the generated policy to your clipboard.
10.  Return to the bucket policy editor in S3 and paste in the policy.
11.  Click  **Save changes**.

### Create a Pipeline in AWS CodePipeline That Deploys a Static Website

1.  Navigate to CodePipeline.
2.  Under  _Pipelines_  click  **Create pipeline**.
3.  In  _Pipeline name_, enter "sample-static-site-pipeline" and click  **Next**.
4.  On the  _Source_  page, set the following values:
    -   _Source provider:_  **AWS CodeCommit**
    -   _Repository name:_  **sample-static-site**
    -   _Branch name:_  **main**
5.  In  _Change detection options_, select  **AWS CodePipeline**  and click  **Next**.
6.  Click  **Skip build stage**  >  **Skip**.
7.  In  _Deploy_  on the next page, select  **Amazon S3**  as the deploy provider.
8.  Set the following values:
    -   _Region:_  **US East (N. Virginia)**
    -   _Bucket:_  Your bucket name
9.  Click  **Extract file before deploy**.
10.  Leave the rest as their defaults and click  **Next**.
11.  Click  **Create pipeline**.
12.  Once the deploy stage completes, click the Amazon S3 URL under  _Deploy_  to verify deployment.
13.  Select the  _Properties_  tab and scroll down to  **Static website hosting**  at the bottom of the page.
14.  Click the bucket website endpoint URL to view the static website.

## Conclusion

Congratulations — you've completed this hands-on lab!
