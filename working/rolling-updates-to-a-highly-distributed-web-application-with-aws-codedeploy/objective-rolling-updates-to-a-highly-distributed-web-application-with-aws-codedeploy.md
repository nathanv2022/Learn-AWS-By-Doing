# Rolling Updates to a Highly Distributed Web Application with AWS CodeDeploy

## Introduction

A DevOps engineer needs to deploy an application to a fleet of existing servers within AWS. When the rollout is complete, they need to push out an update, without taking the application offline. In this lab, we will use AWS CodeDeploy to manage code deployments and updates to a fleet of EC2 instances running in an Auto Scaling group and presented behind an elastic load balancer.

## Objectives

Successfully complete this lab by achieving the following objectives:
Create an S3 Bucket to Store Application Code

1.  Navigate to S3.
2.  Select  **Create bucket**, and enter a unique bucket name. Make a note of this name. From now on in these lab instructions, we will call this our code bucket.
3.  In another browser tab, navigate to the GitHub repository for this course. You'll find a link in the resources section of the lab. Download the repository.
4.  Upload the two zip files into your code bucket.

Create a CodeDeploy In-Place Deployment

### Create a CodeDeploy Application

1.  Navigate to the AWS CodeDeploy service page.
2.  Select  **Applications**  from the left-hand menu.
3.  Select  **Create application**.
4.  For the  _Application name_, enter "demo-app".
5.  For the  _Compute platform_  select  **EC2/On-premises**.
6.  Select  **Create application**.

### Create a CodeDeploy Deployment Group

1.  From the CodeDeploy applications details page, select  **Create deployment group**.
2.  For the  _Deployment group name_, enter "demo-group".
3.  For  _Service role_, select the role created with this lab (the only option).
4.  For  _Deployment type_, select  **In-place**.
5.  For  _Environment configuration_, select  **Amazon EC2 Auto Scaling groups**.
6.  From the dropdown box, select Auto Scaling group  **la-scale-asg-**, which should be the only option.
7.  Scroll down to  _Load balancer_, and select  **Classic Load Balancer**. Then, from the dropdown list, select  **la-lab**  (the only option).
8.  Select  **Create deployment group**.

### Create a CodeDeploy Deployment

1.  From the CodeDeploy deployment group details page, select  **Create deployment**.
2.  Ensure the  _Deployment group_  selected is  **demo-group**.
3.  Ensure the  _Revision type_  selected is  **My application is stored in Amazon S3**.
4.  For  _Revision location_, enter the path of the  `SampleApp_Linux.zip`  object in your code bucket. For example:  `s3://code-bucket-123/SampleApp_Linux.zip`.
5.  Scroll to  _Additional deployment behavior settings_  and under  _Content options_, select  **Overwrite the content**.
6.  Select  **Create deployment**.

Test the Deployed Application

1.  Navigate to the AWS EC2 console.
2.  Select  **Load Balancers**  from the left-hand menu.
3.  Select the  **Description**  tab, and copy the value for  _DNS name_.
4.  Paste that value into a new browser tab.
5.  Ensure you can see the sample web application.

Create a CodeDeploy Blue-Green Deployment

### Create a CodeDeploy Deployment Group

1.  Navigate to the AWS CodeDeploy service page.
2.  Select  **Applications**  from the left-hand menu, then select  **demo-app**  from the list of applications.
3.  From the CodeDeploy applications details page, select  **Create deployment group**.
4.  For the  _Deployment group name_, enter "demo-blue-green".
5.  For  _Service role_  select the role created with this lab (the only option).
6.  For  _Deployment type_, select  **Blue/green**.
7.  For  _Environment configuration_, select  **Automatically copy Amazon EC2 Auto Scaling group**.
8.  From the dropdown box, select Auto Scaling group  **la-scale-asg-**, which should be the only option.
9.  From  _Deployment settings_, ensure  **Reroute traffic immediately**  is selected, and ensure  **Terminate the original instances in the deployment group**  is selected, and that 0's (zeros) are in place for  _Days_,  _Hours_, and  _Minutes_.
10.  Scroll down to  _Load balancer_, select  **Classic Load Balancer**  and from the dropdown list select  **la-lab**  (the only option).
11.  Select  **Create deployment group**.

### Create a CodeDeploy Deployment

1.  From the CodeDeploy deployment group details page, select  **Create deployment**.
2.  Ensure the  _Deployment group_  selected is  **demo-blue-green**.
3.  Ensure the  _Revision type_  selected is  **My application is stored in Amazon S3**.
4.  For  _Revision location_, enter the path of the  `SampleApp_Linux_update.zip`  object in your code bucket. For example:  `s3://code-bucket-123/SampleApp_Linux_update.zip`.
5.  Scroll to  _Additional deployment behavior settings_  and under  _Content options_, select  **Overwrite the content**.
6.  Select  **Create deployment**.

Now wait for the deployment to complete.

Test the Updated Application

**Note**: This is a repeat of the previous testing step. If you have a browser tab open still from that testing, you may simply press refresh in your browser.

1.  Navigate to EC2.
2.  Select  **Load Balancers**  from the left-hand menu.
3.  Select the  **Description**  tab, and copy the value for  _DNS name_.
4.  Paste that value into a new browser tab.
5.  Ensure you can see the sample web application.

You should notice there is a mistake on the page: It says it's deployed with Azure! Next, we will look at rolling this update back.

Perform a Manual Rollback

**Note**: Performing a manual rollback, in this case, is the same as performing an in-place deployment and will follow the same process. There are other options for rolling back code when multiple deployments have been made from the same deployment group. In that case, you can ask CodeDeploy to roll back to the last known good state. In this lab, however, we have only deployed once per deployment group,  _**and**_  the error in the code is not visible to CodeDeploy, as it's a wording issue on the site.

### Create a CodeDeploy Deployment Group

1.  Navigate to CodeDeploy.
2.  Select  **Applications**  from the left-hand menu, then select  **demo-app**  from the list of applications.
3.  From the CodeDeploy applications details page, select  **Create deployment group**.
4.  For the  _Deployment group name_, enter "quick-fix".
5.  For  _Service role_, select the role created with this lab (the only option).
6.  For  _Deployment type_, select  **In-place**.
7.  For  _Environment configuration_, select  **Amazon EC2 Auto Scaling groups**.
8.  From the dropdown box, select Auto Scaling group  **demo-blue-green-**, which should be the only option.
9.  Scroll down to  _Load balancer_, select  **Classic Load Balancer**, and from the dropdown list select  **la-lab**  (the only option).
10.  Select  **Create deployment group**.

### Create a CodeDeploy Deployment

1.  From the CodeDeploy deployment group details page, select  **Create deployment**.
2.  Ensure the  _Deployment group_  selected is  **quick-fix**.
3.  Ensure the  _Revision type_  selected is  **My application is stored in Amazon S3**.
4.  For  _Revision location_, enter the path of the  `SampleApp_Linux.zip`  object in your code bucket. For example:  `s3://code-bucket-123/SampleApp_Linux.zip`.
5.  Scroll to  _Additional deployment behavior settings_  and under  _Content options_, select  **Overwrite the content**.
6.  Select  **Create deployment**.
