# Learn AWS By Doing
 Learn AWS by Doing hands-on labs & projects

## Identity and Access Management (IAM)
  
### Introduction to AWS Identity and Access Management (IAM) (Lab005)

AWS Identity and Access Management (IAM) is a service that allows AWS customers to manage user access and permissions for their accounts, as well as available APIs/services within AWS. IAM can manage users and security credentials (such as API access keys), and allow users to access AWS resources. In this lab, we will walk through the foundations of IAM. We'll focus on user and group management, as well as how to assign access to specific resources using IAM-managed policies. We'll learn how to find the login URL where AWS users can log in to their account and explore this from a real-world use case perspective.

  *OBJECTIVES*
 - [x] Add the Users to the Proper Groups
 - [x] Use the IAM Sign-In Link to Sign In as a User
 
 ### ## Create and Assume Roles in AWS (Lab005/guide-005A)
 AWS Identity and Access Management (IAM) is a service that allows AWS customers to manage user access and permissions for the accounts and available APIs/services within AWS. IAM can manage users, security credentials (such as API access keys), and allow users to access AWS resources.

In this lab, we discover how security policies affect IAM users and groups, and we go further by implementing our own policies while also learning what a role is, how to create a role, and how to assume a role as a different user.

By the end of this lab, you will understand IAM policies and roles, and how assuming roles can assist in restricting users to specific AWS resources.

  *OBJECTIVES*
 - [x] Create the Correct S3 Restricted Policies and Roles
 - [x] Configure IAM So the dev3 User Can Assume the Role
    
## Amazon Simple Storage Service (Amazon S3)

### Creating a Basic Amazon S3 Lifecycle Policy Configuring Amazon S3 (Lab006)
Data is often useful for a limited period of time when it is accessed frequently. Once that period of usefulness has passed though, the data is kept just in case it needs to be reviewed later. This type of data can be archived — and archived storage is typically more cost-effective.

AWS offers Glacier as a long-term archive storage service with lower costs than other storage options. Data can be moved automatically between S3 storage classes using a lifecycle policy. In this hands-on lab, we will create a lifecycle policy.

For the latest on AWS S3, see the information on  [Amazon S3 storage classes](https://aws.amazon.com/s3/storage-classes/?nc=sn&loc=3)

  *OBJECTIVES*
   - [x] Create S3 Bucket
   - [x] Create a Lifecycle Policy

### Create a Static Website Using Amazon S3 (Lab007A)
In this AWS hands-on lab, we will create and configure a simple static website. We will go through configuring that static website with a custom error page. This will demonstrate how to create a cost-efficient website hosting for sites that consist of files like HTML, CSS, JavaScript, fonts, and images.

  *OBJECTIVES*
   - [x] Create an S3 Bucket and Upload an Object
   - [x] Enable Static Website Hosting
   - [x] Apply Bucket Policy

### Configuring Amazon S3 Buckets to Host a Static Website with a Custom Domain (Lab007/Objectives-007)
In this live AWS environment, we will create and configure a simple static website. Then, we will configure that static website with a custom domain, using Route 53 Alias record sets. This lab demonstrates how to create cost-efficient website hosting for sites that consist of files like HTML, CSS, JavaScript, fonts, and images.

  *OBJECTIVES*
   - [x] Create an S3 Bucket and a Static Website
   - [x] Configure a Custom Domain in Route 53
   - [x] Test the Static Website with `dig` and `nslookup` Commands

### Creating Amazon S3 Buckets, Managing Objects, and Enabling Versioning (Lab008)
We will create two S3 buckets and verify public versus non-public access to the buckets. We will also enable and validate versioning based on uploaded objects.

  *OBJECTIVES*
   - [x] Create a Public and Private Amazon S3 Bucket
   - [x] Enable Versioning on the Public Bucket and Validate Access to Different Versions of Files with the Same Name

 ### Set up Cross-Region S3 Bucket Replication (Lab009)
  *OBJECTIVES*
   - [x] Create an S3 Bucket and Enable Replication
   - [x] Test Replication and Observe Results


## Amazon Virtual Private Cloud (VPC)

### Create a Basic VPC and Associated Components in AWS
AWS networking consists of multiple components, and understanding the relationship between the networking components is a key part of understanding the overall functionality and capabilities of AWS. In this hands-on lab, we will create a VPC with an internet gateway, as well as create subnets across multiple Availability Zones.

  *OBJECTIVES*
   - [x] Create a VPC
   - [x] Create an Internet Gateway, and Connect It to the VPC
   - [x] Create a Public and Private Subnet in Different Availability Zones
   - [x] Create Two Route Tables, and Associate Them with the Correct Subnet
   - [x] Create Two Network Access Control Lists (NACLs), and Associate Each with the Proper Subnet

### Building a Three-Tier Network VPC from Scratch in AWS (Lab011)
This lab provides you with the opportunity to get hands-on experience building and connecting the following components inside AWS:

1.  VPC
2.  Subnets
3.  Internet Gateway
4.  Route Tables
5.  Nat Gateway
6.  Network Access Control Lists (NACLs)

These components are the foundation of highly available/fault tolerant networking architecture inside of AWS, while covering concepts such as infrastrucutre, design, routing, and security.

The bare-bones architecture we built in this lab is a design you will frequently see when working in AWS.

  *OBJECTIVES*
   - [ ] Create a VPC
   - [ ] Create six (6) Subnets
   - [ ] Create a NAT Gateway
   - [ ] Create three (3) NACLs and associate them with subnets

### Troubleshooting AWS Network Connectivity: Security Groups and NACLs
Troubleshooting basic network connectivity issues is an important skill. This troubleshooting scenario is an opportunity to assess your skills in this area. In this lab scenario, a junior administrator has deployed a VPC and instances, but there are a few things wrong. `Instance3` is not able to connect to the internet and the junior admin can't determine why. Being a senior administrator, it's your responsibility to troubleshoot the issue and ensure the instance has connectivity to the internet, so that you can ping and log in to the instance using SSH.

  *OBJECTIVES*
   - [ ] Determine Why the Instance Cannot Connect to the Internet
   - [ ] Identify the Issues Preventing the Instance from Connecting to the Internet

### Build Solutions across VPCs with Peering
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Elastic Load Balancing (ELB)

### Use Application Load Balancers for Web Servers
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder


### Amazon Elastic Compute Cloud (EC2)

### Using EC2 Roles and Instance Profiles in AWS
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Create a Windows EC2 Instance and Connect using Remote Desktop Protocol (RDP)
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Creating Your Own EC2 Workstation in the AWS Console
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Create a Custom AMI in AWS
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Resizing Root AWS EBS Volumes to Increase Performance
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Advanced Networking on AWS

### AWS ELB Connectivity Troubleshooting Scenario
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Elastic Block Storage (EBS) and Elastic File System (EFS)

### Reduce Storage Costs with EFS
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Databases on AWS

### AWS DynamoDB in the Console - Creating Tables, Items, and Indexes
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Set Up a WordPress Site Using EC2 and RDS
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Messaging in AWS

### Creating and Subscribing to AWS SNS Topics
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Configuring SNS Push Notifications on S3 Bucket Events Inside of the AWS Console
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder


### Working with AWS SQS Standard Queues
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder


### Working with AWS SQS FIFO Queues
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

## Monitoring on AWS

### Monitoring and Notifications with CloudWatch Events and SNS
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Implement Advanced CloudWatch Monitoring for a Web Server
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Work with AWS VPC Flow Logs for Network Monitoring
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

## Serverless

### Creating a Simple AWS Lambda Function
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Using the AWS CLI to Create an AWS Lambda Function
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### API Gateway Canary Release Deployment
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

### Triggering AWS Lambda from Amazon SQS
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

## Security

### Using Secrets Manager to Authenticate with an RDS Database Using Lambda
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

## Deployments in AWS

### Deploying a Basic Infrastructure Using CloudFormation Templates
  *OBJECTIVES*
   - [ ] Placeholder
   - [ ] Placeholder

