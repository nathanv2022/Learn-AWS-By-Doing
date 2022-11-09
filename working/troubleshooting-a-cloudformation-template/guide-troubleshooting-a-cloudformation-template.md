
# Troubleshooting a CloudFormation Template

## Introduction

In this hands-on lab, you will have the opportunity to identify and troubleshoot a number of errors with a provided CloudFormation template. After fixing all the mistakes, you should be able to successfully deploy the CloudFormation stack.

## OBJECTIVES

Locate the CloudFormation Template

Launch the CloudFormation Stack

Troubleshoot the CloudFormation Template and Re-deploy the Stack


## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  _us-east-1_  region.

### Locate the CloudFormation Template

1.  [Navigate to the lab repo](https://github.com/ACloudGuru/hands-on-aws-troubleshooting/tree/main/Troubleshooting_a_CloudFormation_Template)  and open the  `cf.yml`  file.
2.  Click  **Raw**  and copy the raw file URL.
3.  Using a terminal application, download the  `cf.yml`  file to your local machine:
    
    `curl -O https://raw.githubusercontent.com/ACloudGuru/hands-on-aws-troubleshooting/main/Troubleshooting_a_CloudFormation_Template/cf.yml`
    

### Launch the CloudFormation Stack

1.  In the AWS Console, use the search bar at the top of the page to navigate to the  **CloudFormation**  dashboard.
2.  On the right-hand side of the  **Stacks**  page, open the  **Create stack**  dropdown menu and click  **With new resources (standard)**.
3.  Under  **Specify template**, select  **Upload a template file**.
4.  Click  **Choose file**  and select the lab template saved to your local machine.
5.  Click  **Next**  and review the formatting error.

### Troubleshoot the CloudFormation Template and Re-deploy the Stack

1.  Scroll down and click  **View in Designer**.
2.  Click in the  **template1**  window and press  **ctrl/cmd + f**  to bring up the search box.
3.  Search for  _EC2PublicSecurityGroup_  and in the search box, click  **All**.
4.  Compare the two instances of  **EC2PublicSecurityGroup**  in the template and look for the typo.
5.  On line 164, fix the typo by adding a  _1_  to the end of  **EC2PublicSecurityGroup**.
6.  At the top of the page, click the checkmark button to validate the template.
7.  Once validated, click the upload button to the left to create the stack.
8.  Click  **Next**.
9.  Name the stack  _LabStack1_  and click  **Next**.
10.  Click  **Next**  and click  **Create stack**.
11.  Observe the stack events as it attempts to launch and review any errors that occur.
12.  To correct the AMI-related issue, use the search bar at the top of the page and open the  **EC2**  dashboard in a new tab.
13.  Verify that you are in the  _us-east-1_  region and open the  **Launch instance**  dropdown menu.
14.  Click  **Launch instance**.
15.  Under  **Quick start**, verify that  **Amazon Linux 2**  is selected and copy the pre-populated  **AMI ID**.
16.  Back in the  **CloudFormation**  tab, scroll up and click  **Template**.
17.  Click  **View in Designer**.
18.  Click in the  **template1**  window and press  **ctrl/cmd + f**  to bring up the search box.
19.  Search for  _ami_.
20.  On line 153, replace the  **AMI ID**  next to  `ImageId`  in the template with the  **AMI ID**  copied earlier.
21.  At the top of the page, click the checkmark button to validate the template.
22.  Once validated, click the upload button to the left to create the stack.
23.  Click  **Next**.
24.  Name the stack  **LabStack2**  and click  **Next**.
25.  Click  **Next**  and click  **Create stack**.
26.  Observe the stack events as it attempts to launch and review any errors that occur.
27.  To correct the key pair-related issue, scroll up and click  **Template**.
28.  Press  **ctrl/cmd + f**  to bring up the browser search box and search for  _useast1key_.
29.  Return to the browser tab with the  **EC2**  dashboard.
30.  In the left-hand menu, under  **Network & Security**, click  **Key Pairs**.
31.  Observe that there are no key pairs created currently, despite calling for one in the template.
32.  Click  **Create key pair**.
33.  Name the key  _useast1key_  and click  **Create key pair**.
34.  Back in the  **CloudFormation**  tab, scroll up and click  **View in Designer**.
35.  Since the template has already been validated, click the  **Create stack**  button.
36.  Click  **Next**.
37.  Name the stack  _LabStack3_  and click  **Next**.
38.  Click  **Next**  and click  **Create stack**.
39.  Observe the stack events as it attempts to launch and review any errors that occur.

## Conclusion

Congratulations — you've completed this hands-on lab!


## Additional Resources

Use the  [CloudFormation template on GitHub](https://raw.githubusercontent.com/ACloudGuru/hands-on-aws-troubleshooting/main/Troubleshooting_a_CloudFormation_Template/cf.yml).

## Learning Objectives

Locate the CloudFormation Template

In this lab, you will be provided with a CloudFormation template that contains some issues that need to be fixed. The CloudFormation template is available here:  [https://raw.githubusercontent.com/ACloudGuru/hands-on-aws-troubleshooting/main/Troubleshooting_a_CloudFormation_Template/cf.yml](https://raw.githubusercontent.com/ACloudGuru/hands-on-aws-troubleshooting/main/Troubleshooting_a_CloudFormation_Template/cf.yml)

Launch the CloudFormation Stack

Use the provided template to deploy a CloudFormation stack.

Troubleshoot the CloudFormation Template and Re-deploy the Stack

After launching the stack, you will need to identify the problems with the template, update the template and successfully deploy the CloudFormation stack.
