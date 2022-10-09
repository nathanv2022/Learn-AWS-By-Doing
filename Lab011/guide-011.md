
# Building a Three-Tier Network VPC From Scratch in AWS

## Introduction

In this lab, we're going to create a three-tier VPC network from scratch. We'll start by building the VPC, building and attaching an Internet gateway, and building 6 different subnets inside our VPC:

-   2 DMZ layers
-   2 App layers
-   2 Database layers

Next, we're going to split these pairs of subnets across 2 different Availability Zones — the bare minimum we always want to do for highly available and fault-tolerant architecture in AWS.

Then we're going to create 2 different route tables:

-   A route to the Internet for our public subnets or subnets we want to have access to the open Internet.
-   A route to the NAT gateway so that anything placed in our private subnets will have a route to update software from the open Internet.

Finally, we'll add some security to our subnets with 3 Network Access Control Lists (NACLs), which we'll assign to our pairs of subnet layers.

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  _us-east-1_  region.

### Build and Configure a VPC, Subnets, and Internet Gateway

1.  Select  **All services**.
2.  Click  **VPC**  under  _Networking & Content Delivery_.
3.  In the left sidebar menu, click  **Your VPCs**.
4.  Click  **Create VPC**.
5.  Enter the following values for  _Create VPC_:
    -   _Name tag_: "SysOpsVPC"
    -   _IPv4 CIDR block_  range: "10.99.0.0/16"
    -   Leave the  _IPv6 CIDR block_  and  _Tenancy_  fields as their default values.
6.  Click  **Create VPC**.

#### We have 6 subnets to create — 2 each for the DMZ, app, and database layers.

#### Let's start with the first DMZ layer.

1.  In the left sidebar menu, click  **Subnets**.
2.  Click  **Create subnet**.
3.  Enter for the following values for  _Create subnet_:
    -   _VPC ID_:  **SysOpsVPC**
    -   _Name tag_: "DMZ1public"
    -   _Availability Zone_:  **US East (N. Virginia)/us-east-1a**
    -   _IPv4 CIDR block_  range: "10.99.1.0/24"
4.  Click  **Create subnet**.

#### The second DMZ layer.

1.  Click  **Create subnet**.
2.  Enter for the following values for  _Create subnet_:

-   _VPC ID_:  **SysOpsVPC**
-   _Name tag_: "DMZ2public"
-   _Availability Zone_:  **US East (N. Virginia)/us-east-1b**
-   _IPv4 CIDR block_  range: "10.99.2.0/24"

1.  Click  **Create subnet**.

#### Next, let's make the first app layer.

1.  Click  **Create subnet**.
2.  Enter for the following values for  _Create subnet_:

-   _VPC ID_:  **SysOpsVPC**
-   _Name tag_: "AppLayer1private"
-   _Availability Zone_:  **US East (N. Virginia)/us-east-1a**
-   _IPv4 CIDR block_  range: "10.99.11.0/24"

1.  Click  **Create subnet**.

#### The second app layer.

1.  Click  **Create subnet**.
2.  Enter for the following values for  _Create subnet_:

-   _VPC ID_:  **SysOpsVPC**
-   _Name tag_: "AppLayer2private"
-   _Availability Zone_:  **US East (N. Virginia)/us-east-1b**
-   _IPv4 CIDR block_  range: "10.99.12.0/24"

1.  Click  **Create subnet**.

#### Let's create our first database layer.

1.  Click  **Create subnet**.
2.  Enter for the following values for  _Create subnet_:

-   _VPC ID_:  **SysOpsVPC**
-   _Name tag_: "DBLayer1private"
-   _Availability Zone_:  **US East (N. Virginia)/us-east-1a**
-   _IPv4 CIDR block_  range: "10.99.21.0/24".

1.  Click  **Create subnet**.

#### The second database layer.

1.  Click  **Create subnet**.
2.  Enter for the following values for  _Create subnet_:

-   _VPC ID_:  **SysOpsVPC**
-   _Name tag_: "DBLayer2private"
-   _Availability Zone_:  **US East (N. Virginia)/us-east-1b**
-   _IPv4 CIDR block_  range: "10.99.22.0/24".

1.  Click  **Create subnet**.  _(NOTE: We've now created all 6 subnets. We should have 3 subnets each in the  `us-east-1a`  Availability Zone and the  `us-east-1b`  Availability Zone.)_

_NOTE:_  Notice a pattern in the CIDR block ranges? Using the third octet, we categorized them by groups of 10. So for quick reference, we know that if the third octet is:

-   1 or 2, it's part of the DMZ layer
-   11 or 12, it's part of the app layer
-   21 or 22, it's part of the database layer

_NOTE:_  Whether we labeled these subnets public or private doesn’t  _actually_  make them public or private — it’s just a naming construct. We’ll actually make them public or private in a bit when we route them to a public or private route table.

#### Now, we need to create the Internet gateway.

1.  In the left sidebar menu, click  **Internet Gateways**.
2.  For the  _Name tag_, enter "IGW".
3.  Click  **Create internet gateway**.

_NOTE:_  Once it's created, you'll see its  _State_  says  _Detached_. Even though it's been created, it isn't part of the VPC yet. Let's fix that.

1.  Click  **Actions**  at the top of the screen.
2.  From the dropdown menu, click  **Attach to VPC**.
3.  For  _Avaliable VPCs_, select  **SysOpsVPC**.
4.  Click  **Attach internet gateway**.

_NOTE:_  The state should now say  _Attached_.

## Build and Configure a NAT Gateway, Route Tables, and NACLs

#### First, let's create our NAT gateway.

1.  In the left sidebar menu, click  **NAT Gateways**.  _(NOTE: If there’s one already in your account, you can ignore it; we’re still going to create a new one.)_
2.  Click  **Create NAT Gateway**.
3.  Enter the following for  _Create NAT gateway_:
    -   _Name_: "NGW"
    -   _Subnet_:  **DMZ2public**
    -   _Connectivity type_:  **Public**
    -   _Elastic IP allocation ID_: click  **Allocate Elastic IP**
4.  Click  **Create NAT gateway**.

#### Next, let's create our public route table.

1.  In the left sidebar menu, click  **Route Tables**.  _(NOTE: A route table will already exist — when we created the VPC, it created a default route table. But we're going to create 2 new route tables.)_
    
2.  Click  **Create route table**.
    
3.  Enter the following for  _Create route table_:
    
    -   _Name tag_: "PublicRT"
    -   _VPC_:  **SysOpsVPC**.
4.  Click  **Create route table**.
    

#####Next, let's create our private route table.

1.  Click  **Create route table**.
2.  Enter the following for  _Create route table_:

-   _Name tag_: "PrivateRT"
-   _VPC_:  **SysOpsVPC**.

1.  Click  **Create route table**.

On their own, route tables don't do anything — we have to give them routes  _to_  something. For the public route table, we need to . For the private route table, we need to provide a route to the NAT gateway.

#### Provide a route from the public route table to the Internet gateway.

1.  Select  **PublicRT**.
2.  Click on the  **Routes**  tab.
3.  Click  **Edit routes**.
4.  Click  **Add route**.
5.  For  _Target_, select  **Internet Gateway**.
6.  For  _Destination_, select  **0.0.0.0/0**.
7.  Click  **Save changes**.

We've now created a route from our public route table through the internet gateway into the open internet.

#### Provide a route from the private route table to the NAT gateway.

1.  Select  **PrivateRT**.
2.  Click on the  **Routes**  tab.
3.  Click  **Edit routes**.
4.  Click  **Add route**.
5.  For  _Target_, select  **NAT Gateway**.
6.  For  _Destination_, select  **0.0.0.0/0**.
7.  Click  **Save changes**.

#### First, let's associate our public subnets with the public route table.

1.  Click  **PublicRT**.
2.  Click on the  **Subnet associations**  tab.
3.  Click  **Edit subnet associations**.
4.  Select the  **DMZ1public**  and  **DMZ2public**  subnets.
5.  Click  **Save associations**.

#### Next, let's associate our private subnets with the private route table.

1.  Click  **PrivateRT**.
2.  Click on the  **Subnet associations**  tab.
3.  Click  **Edit subnet associations**.
4.  Select the following subnets:
    -   **AppLayer1private**
    -   **AppLayer2private**
    -   **DBLayer1private**
    -   **DBLayer2private**
5.  Click  **Save associations**.

Now anything placed inside the public route table has a route to the internet gateway, and anything placed inside the private route table has a route to the NAT gateway.

If we have databases or EC2 instances located inside these private subnets, they can get updates from the open internet by going through the NAT gateway, which provides an extra layer of security. Essentially, it’s a one-way street: The resources in the private subnets can access the open internet, but the open Internet cannot access the resources in the private subnets (unless we explicitly allow it).

We’re almost done with this lab. Before we wrap things up, let’s add another layer of security to our VPC by creating an NACL — a sort of firewall for controlling traffic in and out of one or more subnets — for each of our layers.

#### Create the DMZ NACL.

1.  In the left sidebar menu, click  **Network ACLs**.  _(NOTE: We should see a default NACL, similar to route tables. The default NACL was created when we created our VPC. But we're going to create 3 new ones.)_
2.  Click  **Create network ACL**.
3.  For  _Name_, enter "DMZNACL".
4.  For  _VPC_, select  **SysOpsVPC**.
5.  Click  **Create network ACL**.

#### Create the App NACL.

1.  Click  **Create network ACL**.
2.  For  _Name_, enter "APPNACL".
3.  For  _VPC_, select  **SysOpsVPC**.
4.  Click  **Create network ACL**.

#### Create the DB NACL.

1.  Click  **Create network ACL**.
2.  For  _Name_, enter "DBNACL".
3.  For  _VPC_, select  **SysOpsVPC**.
4.  Click  **Create network ACL**.

#### Associate subnets with our NACLs.

1.  Select  **DMZNACL**.
2.  Click on the  **Subnet associations**  tab.
3.  Click  **Edit subnet associations**.
4.  Select the  **DMZ1public**  and  **DMZ2public**  subnets.
5.  Click  **Save changes**.

_NOTE: Now traffic coming in and out of these subnets will be subject to the inbound and outbound rules we set up on this particular NACL. We're not going to set up any rules as part of this lab — right now, we're just building the infrastructure and a shell we could put resources in._

#### Let's finish things up with the NACLs for the remaining layers.

1.  Click  **AppNACL**.
2.  Click on the  **Subnet associations**  tab.
3.  Click  **Edit subnet associations**.
4.  Select the  **AppLayer1private**  and  **AppLayer2private**  subnets.
5.  Click  **Save changes**.
6.  Click  **DBNACL**.
7.  Click on the  **Subnet associations**  tab.
8.  Click  **Edit subnet associations**.
9.  Select the  **DBLayer1private**  and  **DBLayer2private**  subnets.
10.  Click  **Save changes**.

## Conclusion

Congratulations! You've just built a three-tier VPC networking architecture inside AWS.
