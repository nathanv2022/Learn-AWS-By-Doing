
# Rolling Updates to a Highly Distributed Web Application with AWS CodeDeploy

## Introduction

A DevOps engineer needs to deploy an application to a fleet of existing servers within AWS. When the rollout is complete, they need to push out an update, without taking the application offline. In this lab, we will use AWS CodeDeploy to manage code deployments and updates to a fleet of EC2 instances running in an Auto Scaling group and presented behind an elastic load balancer.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

Download the two  `.zip`  files for the lab at the  [lab GitHub page](https://github.com/linuxacademy/content-aws-developertools/raw/master/Rolling-updates-to-a-highly-distributed-web-application-with-AWS-CodeDeploy).

### Create an S3 Bucket to Store Application Code

1.  Navigate to S3.
2.  Click  **+ Create bucket**.
3.  On the  _Name and region_  screen, give your bucket a unique name. (**Note:**  It must be all lowercase letters and be unique across  _all_  AWS accounts.)
4.  Click  **Create**.
5.  Upload both lab  `.zip`  files into your bucket (found on the  [lab GitHub page](https://github.com/linuxacademy/content-aws-developertools/raw/master/Rolling-updates-to-a-highly-distributed-web-application-with-AWS-CodeDeploy)).

### Create a CodeDeploy In-Place Deployment

#### Create a CodeDeploy Application

1.  In a new browser tab, navigate to CodeDeploy.
2.  Click  **Applications**  in the left-hand menu.
3.  Click  **Create application**.
4.  Set the following values:
    -   _Application name_:  **demo-app**
    -   _Compute platform_:  **EC2/On-premises**
5.  Select  **Create application**.

#### Create a CodeDeploy Deployment Group

1.  From the CodeDeploy applications details page, click  **Create deployment group**.
2.  Set the following values:
    -   _Deployment group name_:  **demo-group**
    -   _Service role_: Select the role created with this lab (the only option)
    -   _Deployment type_:  **In-place**
    -   _Environment configuration_:  **Amazon EC2 Auto Scaling groups**
        -   From the dropdown, select  **la-scale-asg-**  (the only option)
    -   _Load balancer_:  **Classic Load Balancer**.
        -   From the dropdown list, select  **la-lab**  (the only option)
3.  Click  **Create deployment group**.

#### Create a CodeDeploy Deployment

1.  From the CodeDeploy deployment group details page, click  **Create deployment**.
2.  Set the following values:
    -   _Deployment group_:  **demo-group**
    -   _Revision type_:  **My application is stored in Amazon S3**
    -   _Revision location_: Enter the path of the  `SampleApp_Linux.zip`  object in your bucket (e.g.,  `s3://<YOUR BUCKET NAME/SampleApp_Linux.zip`)
    -   _Additional deployment behavior settings_  /  _Content options_:  **Overwrite the content**
3.  Click  **Create deployment**. It will take about 10 minutes to finish being created.

### Test the Deployed Application

1.  Navigate to EC2.
2.  Click  **Load Balancers**  in the left-hand menu.
3.  Click the  **Description**  tab, and copy the value for  _DNS name_.
4.  Paste that value into a new browser tab.
5.  Ensure you can see the sample web application.

### Create a CodeDeploy Blue-Green Deployment

#### Create a CodeDeploy Deployment Group

1.  Navigate to CodeDeploy.
2.  Click  **Applications**  in the left-hand menu.
3.  Click  **demo-app**  in the list of applications.
4.  From the CodeDeploy applications details page, click  **Create deployment group**.
5.  Set the following values:
    -   _Deployment group name_:  **demo-blue-green**
    -   _Service role_: Select the role created with this lab (the only option)
    -   _Deployment type_:  **Blue/green**
    -   _Environment configuration_:  **Automatically copy Amazon EC2 Auto Scaling group**
        -   From the dropdown, select  **la-scale-asg-**  (the only option)
    -   _Load balancer_:  **Classic Load Balancer**.
        -   From the dropdown list, select  **la-lab**  (the only option)
    -   _Deployment settings_: Ensure  **Reroute traffic immediately**  is selected, ensure  **Terminate the original instances in the deployment group**  is selected, and ensure 0's (zeros) are in place for  _Days_,  _Hours_, and  _Minutes_.
    -   _Load balancer_:  **Classic Load Balancer**
        -   From the dropdown, select  **la-lab**  (the only option)
6.  Click  **Create deployment group**.

#### Create a CodeDeploy Deployment

1.  From the CodeDeploy deployment group details page, click  **Create deployment**.
2.  Set the following values:
    -   _Deployment group_:  **demo-blue-green**
    -   _Revision type_:  **My application is stored in Amazon S3**
    -   _Revision location_: Enter the path of the  `SampleApp_Linux_update.zip`  object in your bucket (e.g.,  `s3://<YOUR BUCKET NAME>/SampleApp_Linux_update.zip`)
    -   _Additional deployment behavior settings_  /  _Content options_:  **Overwrite the content**
3.  Click  **Create deployment**. It will take about 10 minutes to finish being created.

### Test the Updated Application

> **Note**: This is a repeat of the previous testing step. If you have a browser tab open still from that testing, you may simply press refresh in your browser.

1.  Navigate to EC2.
2.  Click  **Load Balancers**  in the left-hand menu.
3.  Click the  **Description**  tab, and copy the value for  _DNS name_.
4.  Paste that value into a new browser tab.
5.  Ensure you can see the sample web application. You should notice there is a mistake on the page: It says it's deployed with Azure! Next, we will look at rolling this update back.

### Perform a Manual Rollback

> **Note**: Performing a manual rollback, in this case, is the same as performing an in-place deployment and will follow the same process. There are other options for rolling back code when multiple deployments have been made from the same deployment group. In that case, you can ask CodeDeploy to roll back to the last known good state. In this lab, however, we have only deployed once per deployment group,  _**and**_  the error in the code is not visible to CodeDeploy, as it's a wording issue on the site.

#### Create a CodeDeploy Deployment Group

1.  Back in CodeDeploy, click  **Applications**  in the left-hand menu.
2.  Click  **demo-app**  in the list of applications.
3.  From the CodeDeploy applications details page, click  **Create deployment group**.
4.  Set the following values:
    -   _Deployment group name_:  **quick-fix**
    -   _Service role_: Select the role created with this lab (the only option)
    -   _Deployment type_:  **In-place**
    -   _Environment configuration_:  **Amazon EC2 Auto Scaling groups**
        -   From the dropdown, select  **demo-blue-green-**  (the only option)
    -   _Load balancer_:  **Classic Load Balancer**.
        -   From the dropdown list, select  **la-lab**  (the only option)
5.  Click  **Create deployment group**.

#### Create a CodeDeploy Deployment

1.  From the CodeDeploy deployment group details page, click  **Create deployment**.
2.  Set the following values:
    -   _Deployment group_:  **quick-fix**
    -   _Revision type_:  **My application is stored in Amazon S3**
    -   _Revision location_: Enter the path of the  `SampleApp_Linux.zip`  object in your bucket (e.g.,  `s3://<YOUR BUCKET NAME>/SampleApp_Linux.zip`)
    -   _Additional deployment behavior settings_  /  _Content options_:  **Overwrite the content**
3.  Click  **Create deployment**. It will take about 10 minutes to finish being created.

## Conclusion

Congratulations on successfully completing this hands-on lab!
