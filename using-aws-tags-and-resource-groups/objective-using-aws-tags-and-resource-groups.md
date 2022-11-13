# Using AWS Tags and Resource Groups

## Introduction

To simplify the management of AWS resources such as EC2 instances, you can assign metadata using tags. Resource groups can then use these tags to automate tasks on large numbers of resources at one time. They serve as a unique identifier for custom automation, to break out cost reporting by department, and much more. In this hands-on lab, you will explore tag restrictions and best practices for tagging strategies. You will also get experience with the Tag Editor, AWS resource group basics, and leveraging automation through the use of tags

## Objectives
Successfully complete this lab by achieving the following objectives:
  
1. Set Up AWS Config

Navigate to Config, and use  **1-click Setup**  to set up Config.

2. Tag an AMI and EC2 Instance

Navigate to EC2, and select any of the instances and create an AMI image from the instance. For the  **Image name**, enter  _Base_, and create the image. Once the image state is  **available**, launch a new instance of type  **t3.micro**, and name it  _My Test Server_. Assign the existing  **SecurityGroupWeb**  security group to the instance, and launch the instance.

3. Tag Applications with the Tag Editor

Navigate to  **Resource Groups & Tag Editor**  >  **Tag Editor**. Filter by  _EC2_  and  _S3 bucket_, and locate all resources related to  **Module 1**. Add a new tag to the resources with a  **Tag Key**  called  _Module_  and a  **Tag Value**  called  _Starship Monitor_.

Repeat the process for  **Module 2**  resources, and create a new tag with a  **Tag Key**  called  _Module_  and a  **Tag Value**  called  _Warp Drive_.

4. Create Resource Groups and Use AWS Config Rules for Compliance

Create two resource groups (one for each module), and then use Config to set up a rule to check if instances are using an approved AMI. The AMI to check against is the AMI of the  **My Test Server**  instance. Reboot all instances, and observe the results in Config.
