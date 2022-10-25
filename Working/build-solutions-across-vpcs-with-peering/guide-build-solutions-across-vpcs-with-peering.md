# Build Solutions across VPCs with Peering

## Description

A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses or IPv6 addresses. In this lab, you will create a new VPC for your WordPress blog to run from. You will then create a VPC peering connection between the new VPC and an existing database VPC. By the end of this lab, you will understand how to create a new VPC from scratch, attach internet gateways, edit routing tables, and peer multiple VPCs together.

## Objectives (Challenge Mode)

 - [ ]   1. Create Web_VPC Subnets and Attach a New Internet Gateway
Using the AWS console, create the `Web_VPC` VPC with the `192.168.0.0/16` IPv4 CIDR block. Create the `WebIG` internet gateway. Modify the route table to attach the internet gateway to the `Web_VPC`.

 - [ ] 2. Create a Peering Connection
Create a peering connection called `DBtoWeb`. Peer the newly created `Web_VPC` with the `DB_VPC`. Ensure `DB_VPC` is the requester and `Web_VPC` is the accepter. Accept the request.

 - [ ] 3. Create an EC2 Instance and configure Wordpress
Launch a new public facing Ubuntu Server 20.04 LTS EC2 instance in the `Web_VPC` VPC using the provided bootstrap user data script.
====================

    #!/bin/bash
    sudo apt update -y
    sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip perl mysql-server apache2 libapache2-mod-php php-mysql -y
    wget https://github.com/ACloudGuru-Resources/course-aws-certified-solutions-architect-associate/raw/main/lab/5/wordpress.tar.gz
    tar zxvf wordpress.tar.gz
    cd wordpress
    wget https://raw.githubusercontent.com/ACloudGuru-Resources/course-aws-certified-solutions-architect-associate/main/lab/5/000-default.conf
    cp wp-config-sample.php wp-config.php
    perl -pi -e "s/database_name_here/wordpress/g" wp-config.php
    perl -pi -e "s/username_here/wordpress/g" wp-config.php
    perl -pi -e "s/password_here/wordpress/g" wp-config.php
    perl -i -pe'
      BEGIN {
        @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
        push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
        sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
      }
      s/put your unique phrase here/salt()/ge
    ' wp-config.php
    mkdir wp-content/uploads
    chmod 775 wp-content/uploads
    mv 000-default.conf /etc/apache2/sites-enabled/
    mv /wordpress /var/www/
    apache2ctl restart

====================
Configure Wordpress by editing  `/var/www/wordpress/wp-config.php`  to point  `DB_HOST`  to the RDS database endpoint.

 - [ ] 4. Modify the RDS Security Groups to Allow Connections from the Web_VPC VPC
The RDS instance requires a security group modification to allow access from `192.168.0.0/16`.

 - [ ] Test WordPress
Visit the IP address of your EC2 instance in a web browser, and confirm WordPress is working correctly and communicating with the RDS instance via VPC peering.
    
## Guided Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're in the N. Virginia (`us-east-1`) Region throughout the lab.

### Create  `Web_VPC`  Subnets and Attach a New Internet Gateway

#### Create a VPC

1.  Use the top search bar to look for and navigate to  **VPC**.
2.  Under  **Resources by Region**, click  **VPCs**.
3.  Use the top search bar to look for and navigate to  **RDS**  in a new tab.
4.  Click  **DB Instances**, and observe the instance created for this lab.
    
    > **Note:**  Keep this tab open for use later on in the lab.
    
5.  Go back to your VPC tab, and click  **Create VPC**.
6.  Ensure the  `VPC only`  option is selected.
7.  Set the following values:
    -   **Name tag:**  Enter  _Web_VPC_.
    -   **IPv4 CIDR block:**  Enter  `192.168.0.0/16`.
8.  Leave the rest of the settings as their defaults, and click  **Create VPC**.

#### Create a Subnet

1.  On the left menu under  **VIRTUAL PRIVATE CLOUD**, select  **Subnets**.
2.  Click  **Create subnet**.
3.  For  **VPC ID**, select the newly created  `Web_VPC`.
4.  Under  **Subnet settings**, set the following values:
    -   **Subnet name:**  Enter  _WebPublic_.
    -   **Availability Zone:**  Select  **us-east-1a**.
    -   **IPv4 CIDR block:**  Enter  `192.168.0.0/24`.
5.  Click  **Create subnet**.

#### Create an Internet Gateway

1.  On the left menu, select  **Internet Gateways**.
2.  Click  **Create internet gateway**.
3.  For  **Name tag**, enter  _WebIG_.
4.  Click  **Create internet gateway**.
5.  In the green notification at the top of the page, click  **Attach to a VPC**.
6.  In  **Available VPCs**, select the  `Web_VPC`  and click  **Attach internet gateway**.
7.  On the left menu, select  **Route Tables**.
8.  Select the checkbox for the  `Web_VPC`.
9.  Underneath, select the  **Routes**  tab and click  **Edit routes**.
10.  Click  **Add route**.
11.  Set the following values:
    -   **Destination:**  Enter  `0.0.0.0/0`.
    -   **Target:**  Select  **Internet Gateway**, and select the internet gateway that appears in the list.
12.  Click  **Save changes**.

### Create a Peering Connection

1.  On the left menu, select  **Peering Connections**.
2.  Click  **Create peering connection**.
3.  Set the following values:
    -   **Name:**  Enter  _DBtoWeb_.
    -   **VPC (Requester):**  Select the  `DB_VPC`.
    -   **VPC (Accepter):**  Select the  `Web_VPC`.
4.  Click  **Create peering connection**.
5.  At the top of the page, click  **Actions**  >  **Accept request**.
6.  Click  **Accept request**.
7.  On the left menu, select  **Route Tables**.
8.  Select the checkbox for the  `Web_VPC`.
9.  Underneath, select the  **Routes**  tab, and click  **Edit routes**.
10.  Click  **Add route**.
11.  Set the following values:
    -   **Destination:**  Enter  `10.0.0.0/16`.
    -   **Target:**  Select  **Peering Connection**, and select the peering connection that appears in the list.
12.  Click  **Save changes**.
13.  Go back to  **Route Tables**, and select the checkbox for the  `DB_VPC`  instance with a  **Main**  column value of  **Yes**.
14.  Underneath, select the  **Routes**  tab, and click  **Edit routes**.
15.  Click  **Add route**.
16.  Set the following values:
    -   **Destination:**  Enter  `192.168.0.0/16`.
    -   **Target:**  Select  **Peering Connection**, and select the peering connection that appears in the list.
17.  Click  **Save changes**.

### Create an EC2 Instance and Configure WordPress

1.  In a new browser tab, navigate to EC2.
    
2.  Click  **Launch instance**  >  **Launch instance**.
    
3.  Scroll down and under  **Quick Start**, select the  **Ubuntu**  image box. (You can skip the  **Name**  field before this.)
    
4.  Under  **Amazon Machine Image (AMI)**, click the dropdown and select  **Ubuntu Server 20.04 LTS**.
    
5.  Under  **Instance type**, click the dropdown and select  **t3.micro**.
    
6.  For  **Key pair**, click the dropdown and select  **Proceed without a key pair**.
    
7.  In the  **Network settings**  section, click the  **Edit**  button.
    
8.  Set the following values:
    
    -   **VPC:**  Select the  `Web_VPC`.
    -   **Subnet:**  Ensure the  **WebPublic**  subnet is selected.
    -   **Auto-assign public IP:**  Select  **Enable**.
9.  Under  **Firewall (security groups)**, ensure  **Create security group**  is selected (the default value).
    
10.  Scroll down and click  **Add security group rule**.
    
11.  Set the following values for the new rule (i.e.,  **Security group rule 2**):
    
    -   **Type:**  Select  **HTTP**.
    -   **Source:**  Select  `0.0.0.0/0`.
    -   **Type:**  Select  **SSH**.
    -   **Source:**  Select  `0.0.0.0/0`.
12.  Scroll to the bottom, and expand  **Advanced details**.
    
13.  At the bottom, under  **User data**, copy and paste the following bootstrap script:
==========
#!/bin/bash
sudo apt update -y
sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip perl mysql-server apache2 libapache2-mod-php php-mysql -y
wget https://github.com/ACloudGuru-Resources/course-aws-certified-solutions-architect-associate/raw/main/lab/5/wordpress.tar.gz
tar zxvf wordpress.tar.gz
cd wordpress
wget https://raw.githubusercontent.com/ACloudGuru-Resources/course-aws-certified-solutions-architect-associate/main/lab/5/000-default.conf
cp wp-config-sample.php wp-config.php
perl -pi -e "s/database_name_here/wordpress/g" wp-config.php
perl -pi -e "s/username_here/wordpress/g" wp-config.php
perl -pi -e "s/password_here/wordpress/g" wp-config.php
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php
mkdir wp-content/uploads
chmod 775 wp-content/uploads
mv 000-default.conf /etc/apache2/sites-enabled/
mv /wordpress /var/www/
apache2ctl restart
    
==========

15.  At the bottom, click  **Launch Instance**.
    
    > **Note:**  It may take a few minutes for the new instance to launch.
    
16.  From the green box that appears after the instance launches, open the link for the instance in a new browser tab.
    
17.  Observe the  **Instance state**  column, and check to ensure it is  **Running**  before you proceed.
    
18.  Select the checkbox for the new instance and click  **Connect**.
    
19.  Click  **Connect**.
    
    > **Note:**  The startup script for the instance may take a few minutes to complete and you may need to wait for it to complete before proceeding with the next step.
    
20.  To confirm WordPress installed correctly, view the configuration files:
    
    `cd /var/www/wordpress`
    
    `ls`
    
21.  To configure WordPress, open  `wp-config.php`:
    
    `sudo vim wp-config.php`
    
22.  Go back to your browser tab with RDS.
    
23.  Click the link to open the provisioned RDS instance.
    
24.  Under  **Connectivity & security**, copy the RDS  **Endpoint**.
    
25.  Go back to the tab with the terminal, and scroll down to  `/** MySQL hostname */`.
    
26.  Press  `i`  to enter Insert mode.
    
27.  Replace  `localhost`  with the RDS endpoint you just copied. Ensure it remains wrapped in single quotes.
    
28.  Press  **ESC**  followed by  `:wq`, and press  **Enter**. Leave this tab open.
    

### Modify the RDS Security Groups to Allow Connections from the  `Web_VPC`  VPC

1.  Go back to your RDS browser tab.
2.  In  **Connectivity & security**, click the active link under  **VPC security groups**.
3.  At the bottom, select the  **Inbound rules**  tab.
4.  Click  **Edit inbound rules**.
5.  Click  **Add rule**.
6.  Under  **Type**, search for and select  **MYSQL/Aurora**.
7.  Under  **Source**, search for and select  `192.168.0.0/16`.
8.  Click  **Save rules**.
9.  Return to the terminal page.
10.  Below the terminal window, copy the public IP address of your server.
11.  Open a new browser tab and paste the public IP address in the address bar. You should now see the WordPress installation page.
12.  Set the the following values:
    -   **Site Title:**  Enter  _A Blog Guru_.
    -   **Username:**  Enter  _guru_.
    -   **Your Email:**  Enter  _[test@test.com](mailto:test@test.com)_.
13.  Click  **Install WordPress**.
14.  Reload the public IP address in the address bar to view your newly created WordPress blog.

## Conclusion

Congratulations — you've completed this hands-on lab!

### Troubleshooting

If the website isn't loading the way you expected at the end of this lab, here are some tips to help troubleshoot:

-   Check the status of the lab objectives - are any not yet completed?
-   Is everything you set up ready to use? Check things like the VPC peering connection, which requires you to specifically accept the connection request.
-   Does the database error page load after a minute or so of waiting, or does no page load at all? This gives a hint on whether the issue may be with the peering or the security groups.
