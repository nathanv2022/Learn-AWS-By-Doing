
# Creating an AWS Site-to-Site VPN


## Description

In this lab, we'll create an AWS Site-to-Site VPN connection from an AWS VPC used by our organization's main office to a private, remote data center used by a branch office. We will simulate the branch office network via a second AWS VPC, installing and configuring a software-based customer VPN gateway running on an EC2 instance. We'll also create a virtual gateway and configure the Site-to-Site VPN to use a secure IPsec tunnel between sites. We will then test connectivity.

## Objectives

Successfully complete this lab by achieving the following learning objectives:

Verify Resources and Examine Network Configuration

Verify that the resources below exist.

> **Note:**  If using the pre-configured lab environment, these resources have already been configured for you. If not, you'll need to create them.

-   **Two VPCs in different Availability Zones**:
    -   `VPC-MainOffice`  with CIDR block 10.10.0.0/16
    -   `VPC-BranchOffice`  with CIDR block 10.20.0.0/16
-   **A public subnet in each VPC**:
    -   `Subnet-MainOffice-Public`  with CIDR block 10.10.1.0/24
    -   `Subnet-BranchOffice-Public`  with CIDR block 10.20.1.0/24
-   **An internet gateway (IGW) in each VPC**
-   **Two route tables, each attached to the appropriate subnet**:
    -   _Names_:  `RT-MainOffice`  and  `RT-BranchOffice`
    -   _Routes_: Local, and 0.0.0.0/0 pointing to the IGW

Create Two EC2 Instances

Create two new EC2 instances: one in  `VPC-MainOffice`  and one in  `VPC-BranchOffice`.

#### `EC2-MainOffice`

-   _AMI_:  **Amazon Linux 2**
-   _Instance type_:  **t2.medium**
-   _Network_:  **VPC-MainOffice**
-   _Subnet_:  **Subnet-MainOffice-Public**
-   _Auto-assign Public IP_:  **Enable**
-   _Tags_:
    -   _Key_:  **Name**;  _Value_:  **EC2-MainOffice**
-   _Security group_:  **Create a new security group**:
    -   _Type_:  **SSH**;  _Source_:  **My IP**
    -   _Type_:  **All TCP**;  _Source_:  **Custom**,  **10.20.0.0/16**
    -   _Type_:  **All UDP**;  _Source_:  **Custom**,  **10.20.0.0/16**
    -   _Type_:  **All ICMP - IPv4**;  _Source_:  **Custom**,  **10.20.0 0/16**
-   _Key pair_:  **Create a new key pair**:
    -   _Key pair name_:  **Key-MainOffice**
    -   Download and save key pair.

#### `EC2-BranchOffice`

-   _AMI_:  **Amazon Linux 2**
-   _Instance type_:  **t2.medium**
-   _Network_:  **VPC-BranchOffice**
-   _Subnet_:  **Subnet-BranchOffice-Public**
-   _Auto-assign Public IP_:  **Enable**
-   _Tags_:
    -   _Key_:  **Name**;  _Value_:  **EC2-BranchOffice**
-   _Security group_:  **Create a new security group**:
    -   _Type_:  **SSH**;  _Source_:  **My IP**
    -   _Type_:  **All TCP**;  _Source_:  **Custom**,  **10.10.0.0/16**
    -   _Type_:  **All UDP**;  _Source_:  **Custom**,  **10.10.0.0/16**
    -   _Type_:  **All ICMP - IPv4**;  _Source_:  **Custom**,  **10.10.0.0/16**
-   _Key pair_:  **Create a new key pair**:
    -   _Key pair name_:  **Key-BranchOffice**
    -   Download and save key pair.

Once  `EC2-BranchOffice`  is created, disable the source/destination checks.

Create Virtual Private Network Resources

Create the following resources:

-   Virtual private gateway attached to  `VPC-MainOffice`
    -   _Name_:  **VPG-MainBranch**
-   Customer gateway
    -   _Name_:  **CGW-MainBranch**
    -   _Routing_:  **Static**
    -   _IP Address_: Public IP address of  `EC2-BranchOffice`
-   Site-to-Site VPN connection
    -   _Name_:  **VPN-MainBranch**
    -   _Virtual Private Gateway_:  **VPG-MainBranch**
    -   _Customer Gateway_:  **CGW-MainBranch**
    -   _Routing Options_:  **Static**
    -   _IP Prefixes_:  **10.20.0.0/16**

It may take several minutes for the VPN connection to move from  <span style="color:gold">**pending**</span>  to  <span style="color:green">**available**</span>.

Install and Configure Openswan

1.  Connect via SSH to  `EC2-BranchOffice`.
    
2.  Install Openswan:
    
    `sudo su`
    
    `yum install openswan`
    
3.  Configure  `/etc/ipsec.conf`  — if there is a  `#`  in front of this line, remove it:
    
    `include /etc/ipsec.d/*.conf`
    
4.  Configure  `/etc/sysctl.conf`, adding these lines to the file:
    
    `net.ipv4.ip_forward = 1 net.ipv4.conf.default.rp_filter = 0 net.ipv4.conf.default.accept_source_route = 0`
    
5.  Configure  `/etc/ipsec.d/aws.conf`, adding these lines to the file:
    

`conn Tunnel1 authby=secret auto=start left=%defaultroute leftid=<CUSTOMER_GATEWAY_IP_ADDRESS> right=<VIRTUAL_PRIVATE_GATEWAY_IP_ADDRESS> type=tunnel ikelifetime=8h keylife=1h phase2alg=aes128-sha1;modp1024 ike=aes128-sha1;modp1024 keyingtries=%forever keyexchange=ike leftsubnet=10.20.0.0/16 rightsubnet=10.10.0.0/16 dpddelay=10 dpdtimeout=30 dpdaction=restart_by_peer`

1.  Configure  `/etc/ipsec.d/aws.secrets`, using this format:
    
    `<CUSTOMER_GATEWAY_IP_ADDRESS> <VIRTUAL_PRIVATE_GATEWAY_IP_ADDRESS>: PSK "<PRE_SHARED_KEY>"`
    
    For example:
    
    `50.100.25.6 75.80.65.12: PSK "34nkfwoe732ddf"`
    
2.  Restart the network service:
    
    `service network restart`
    
3.  Set the ipsec service to run automatically if the server restarts:
    
    `chkconfig ipsec on`
    
4.  Start the ipsec service:
    
    `service ipsec start`
    
5.  Check the status of the ipsec service:
    
    `service ipsec status`
    

Test Connectivity Across VPN

1.  Connect via SSH to  `EC2-BranchOffice`, and attempt to ping  `EC2-MainOffice`:
    
    `ping <EC2-MainOffice_PRIVATE_IP_ADDRESS>`
    
2.  Connect via SSH to  `EC2-MainOffice`, and attempt to ping  `EC2-BranchOffice`:
    
    `ping <EC2-BranchOffice_PRIVATE_IP_ADDRESS>`
