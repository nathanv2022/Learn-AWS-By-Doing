
# Create a VPC Endpoint and S3 Bucket in AWS

## Introduction

In this hands-on lab, we will create a VPC endpoint and an S3 bucket to illustrate the benefits available for our cloud implementations. VPC endpoints can be used instead of NAT gateways to provide access to AWS resources. Many customers have legitimate privacy and security concerns about sending and receiving data across the public internet. VPC endpoints for S3 can alleviate these challenges by using the private IP address of an instance to access S3 with no exposure to the public internet.

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  _us-east-1_  Region.

### Create an S3 Bucket

1.  Begin by navigating to EC2.
2.  In  _Resources_, click  **Instances (running)**.
3.  Select the checkbox next to one of the instances.
4.  In  _Details_  below, notice that the  _Public IPv4 address_  field is either blank or has an address value. The instance that has the IPv4 address is the  **public**  instance, and the instance where this field is blank is the  **private**  instance.
5.  In the  _Name_  column at the top, click the blank field, and rename the instances to  _public_  and  _public_  accordingly.
6.  Navigate to S3.
7.  Click  **Create bucket**.
8.  In  _Bucket name_, create an S3 bucket beginning with the name  `vpcendpointbucket`  followed by random characters to ensure the bucket is globally unique.
9.  At the bottom, click  **Create bucket**.

### Create a VPC Endpoint

1.  Navigate to VPC.
2.  From the left navigation, select  **Endpoints**.
3.  Click  **Create Endpoint**.
4.  Leave  _Service category_  as  **AWS services**.
5.  For  _Service Name_, search for and select  **com.amazonaws.us-east-1.s3**  (with a  _Type_  of  **Gateway**).
6.  For  _VPC_, select the provided VPC from the dropdown.
7.  You have been provided with both a public and private route table for this lab. Before proceeding, you'll need to identify the private route table in VPC. Keep this tab open, but open another instance of VPC in a new tab.
8.  From the left navigation, select  **Route Tables**.
9.  Select the route with no name (the other will be called  **Endpointrb**).
10.  Select the  _Routes_  tab below. Note the  _Target_  shows only a local IP. This is the private table.
11.  Go back up to  _Name_, click the blank field, and enter  _private_.
12.  With the private route still selected, select the  _Subnet Associations_  tab below.
    
    > **Note:**  If you do not see an associated subnet, click  **Edit subnet associations**. Select the one with  **private**  in the  _Route table ID_, and click  **Save associations**.
    
13.  Keep note of the subnet name for the following steps.
14.  Go back to your first browser tab with the VPC endpoint console.
15.  For  _Configure route tables_, select the private subnet you just copied (the name you just noted will match the name in the  **Associated with**  column).
16.  Leave the rest of the fields as their defaults, and click  **Create endpoint**.
17.  Click  **Close**.

### Verify VPC Endpoint Access to S3

1.  From the VPC navigation menu, select  **Route Tables**.
    
2.  Select the  **private**  route table.
    
3.  Select the  **Routes**  tab. Note that AWS has automatically updated the private route table with a route to the VPC endpoint.
    
    > **Note:**  If you do not see this right away, you may have to wait a minute and refresh to see the update.
    
4.  Open a terminal, and SSH into the public instance, replacing  `PUBLIC_IP_ADDRESS`  with the public IP address found in the  **Cloud Server of Public Instance**  section from your lab credentials (use the password from here as well):
    
    `ssh cloud_user@<PUBLIC_IP_ADDRESS>`
    
5.  From the public instance, SSH into the private instance using the private IP address and password found in the  **Cloud Server of Private Instance**  section from your lab credentials:
    
    `ssh cloud_user@<PRIVATE_IP_ADDRESS>`
    
6.  View the S3 bucket:
    
    `aws s3 ls`
    
    You should see the 2 S3 buckets — the one provided for the lab and the one you created.
    

## Conclusion

Congratulations — you've completed this hands-on lab! You created an S3 bucket and a VPC endpoint that allows the private EC2 instance to reach S3 without using the public internet.
