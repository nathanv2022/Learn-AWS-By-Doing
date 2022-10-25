# Connecting VPCs with VPC Peering in AWS

## Introduction

In this hands-on lab scenario, you’re a cloud network engineer working for a large organization that has multiple VPCs. Each VPC is dedicated to a business unit (e.g., Marketing, Sales, Services, etc.). The Marketing department requires access to all resources in the Sales department, and vice versa. We will create a VPC peering connection between the Marketing and Sales VPCs, allowing them to act as if they are on the same network. We'll also add the necessary routes to the associated network route tables.

## Prerequisites

Log in to the live AWS environment using the provided credentials. Make sure you are in  `us-east-1`  when you work in this environment.

If you are using PuTTY to connect to EC2 instances, use  [these instructions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html).

For help troubleshooting your SSH connection,  [click here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html).

## Challenge Objectives

Secure the EC2 Instance

1. In the AWS Management Console, navigate to VPC.
2. Under  **SECURITY**, select  **Network ACLs**.
3. Select  **Public2-NACL**.
4. Click  **Inbound Rules**.
5. Click  **Edit Inbound Rules**.
6. Change the source for Rule #  `104`  to  `10.0.0.0/13`.
7. Click  **Save**.

Create a VPC Peering Connection

1. Navigate to VPC.
2. Under  **VIRTUAL PRIVATE CLOUD**, select  **Peering Connections**.
3. Click  **Create Peering Connection**.
4. Set the following values:
    - _Peering connection name tag:_  **Marketing<->Sales**
    - _VPC (Requester):_  **Marketing-VPC**
    - _VPC (Accepter):_  **Sales-VPC**
5. Leave the rest as their defaults and click  **Create Peering Connection**.
6. Click  **OK**. The  _Status_  should now be  _Pending Acceptance_.
7. To accept the VPC peering connection, select the newly created connection and click  **Actions**  >  **Accept Request**.
8. Review and click  **Yes, Accept**
9. Click  **Close**.

Configure Routing

1. Under  **VIRTUAL PRIVATE CLOUD**, select  **Route Tables**.
2. Select  **Public1-RT**.
3. Select  **Routes**.
4. Click  **Edit Routes**.
5. Click  **Add Route**  and enter the following values:
    - Destination:  **10.2.0.0/16**
    - Target:  **Marketing<->Sales**
6. Click  **Save routes**.
7. Repeat the steps above for  **Private1-RT**.
8. Repeat the steps above for  **Public2-RT**  and  **Private2-RT**, setting the  _Destination_  to  **10.1.0.0/16**.
