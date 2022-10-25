# AWS ELB Connectivity Troubleshooting Scenario

## Introduction

The goal of this hands-on lab is to fix the connectivity issue in the AWS environment so you can view the Linux 2 AMI/Apache test page of the provisioned EC2 instances via the elastic load balancer's DNS name.

Log in to the AWS live environment via the  `cloud_user`  credentials provided. Please make sure you are working in the  `us-east-1`  (N. Virginia) region.

## First Attempt to Connect

Once inside AWS, navigate to EC2 and then head to the running instances. Copy and paste the public IP address of either one of the instances into a new browser tab to verify Apache has been correctly installed (which is confirmed by the browser displaying the test page).

Back in the AWS console, click  **Load Balancers**  in the sidebar. Copy and paste the DNS name listed for the existing load balancer into a new browser tab. Here, we'll see the test page isn't loading.

Let's pinpoint the problem and resolve it.

## Understanding the Architecture

As we saw before, we have two running EC2 instances, which are both in public subnets with public IP addresses. We know we can take the public IP address of one of the instances and access the test page, so we know everything is working as far as security groups, network access control lists, etc. We also know there's a proper internet gateway, which has been attached with proper routing through the route table.

We also know, however, there's an issue with the elastic load balancer itself, since we weren't able to access the test page using its DNS name.

Let's take a look at the potential issues.

## Issue #1

Back in the AWS console, head to the load balancer page. Make sure our load balancer is selected, and scroll to the  _Description_  section below. Under  _Security_, click the listed security group.

On the security group page, click the  **Inbound**  tab. Here's a problem: The security group is only allowing traffic over port 22, but it should be HTTP over port 80.

Let's fix it.

## Solution #1

Click  **Edit**, change  _Type_  to  **HTTP**, and click  **Save**.

Now, copy and paste the elastic load balancer's DNS name into a browser tab again. Alas, we still don't see the test page. Let's continue our diagnosis.

## Issue #2

Back in the load balancer page, click the  **Instances**  tab in the section below. Under  _Status_, we'll see both instances are listed as  _OutOfService_  — which means there could be an issue with the health checks.

Click the  **Health Checks**  tab, where we'll see the issue: The  _Ping Target_  is set to  _TCP:8000_. That's not a port we want to ping and test our health check against — it should be set to port 80.

## Solution #2

Click  **Edit Health Check**, change  _Ping Port_  to  **80**, and click  **Save**.

Click the  **Instances**  tab again, where we should see their status has changed to  _InService_.

Try the elastic load balancer's DNS name in the browser again. This time, we should successfully see the test page.

## Conclusion
