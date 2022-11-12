
# Set Up a WordPress Site Using EC2 and RDS

## Introduction

Amazon Relational Database Service (Amazon RDS) allows users to easily create, operate, and scale a relational database in the cloud. In this lab, we create an RDS database, install a web server and configure WordPress to connect to the RDS database. We then run the final configuration through the web browser and are presented with a working WordPress blog. By the end of this lab, the user will understand how to create an RDS database and configure WordPress to use it to store data.

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  _us-east-1_  region.

### Create RDS Database

1.  In the AWS management console, enter "RDS" into the search bar on top.
2.  From the results, select  **RDS**.
3.  Click  **Create database**.
4.  On the  _Create database_  page, set the following parameters:
    -   Select  **Standard create**.
    -   Under  _Engine options_, select  **MySQL**.
    -   Select  _Version_:  **MySQL 8.0.28**.
    -   Under  _Templates_, select  **Free tier**
    -   Under  _DB instance identifier_, enter "wordpress" and copy this into your clipboard.
    -   Use "wordpress" as the username and the password.
    -   Under  _DB instance class_, select  **db.t2.micro**.
    -   Under  _Connectivity_, select the existing VPC and leave the  **Don't connect to an EC2 compute resource**  selected.
    -   Under  _VPC security group_, select the non-default security group from the dropdown menu and remove the default security group.
    -   Under  _Availability zone_, select  **us-east-1a**.
    -   Expand  _Additional configuration_  and, under  _Initial database name_, enter "wordpress".
    -   Under  _Backups_, uncheck the  **Enable automatic backups**  option.
    -   Click  **Create database**.
5.  While the database is created, enter "EC2" in the search bar on top.
6.  From the results, right-click  **EC2**  and open it in a new browser window or tab.
7.  Under  `Resources`, click  **Instances (running)**.
8.  Click the checkbox next to  **webserver-01**.
9.  In the top right, click  **Connect**.
10.  Click  **Connect**.

### Install Apache and Dependencies

1.  In the terminal, install the Apache 2 web server, libraries, PHP, and PHP MySQL:
    
    `sudo apt install apache2 libapache2-mod-php php-mysql -y`
    
2.  When prompted, press Y for yes and hit Enter.
    
3.  Go into the newly created  `/var/www`  directory:
    
    `cd /var/www`
    
4.  View the contents of the directory:
    
    `ls`
    
5.  Put  `wordpress`  into its own folder in the  `/var/www`  directory that we're currently in:
    
    `sudo mv /wordpress .`
    
6.  View the contents of the directory:
    
    `ls`
    
7.  Move into the  `wordpress`  directory:
    
    `cd wordpress`
    
8.  Move the Apache configuration file into  `/etc/apache2/sites-enabled/`  to enable the WordPress website to work from  `/var/www/wordpress`:
    
    `sudo mv 000-default.conf /etc/apache2/sites-enabled/`
    
9.  Restart the Apache 2 configuration:
    
    `sudo apache2ctl restart`
    
10.  Open the WordPress config PHP file for editing:
    
    `sudo nano wp-config.php`
    
11.  Return to the browser window or tab that has the RDS Databases open.
    
12.  Click the  **wordpress**  database.
    
13.  In the  _Connectivity & security_  tab, under  _Endpoint_, copy the endpoint provided into your clipboard.
    
14.  Return to your terminal.
    
15.  Change the line  `define('DB_HOST', 'localhost');`  to read:
    
    `define('DB_HOST', '<INSERT ENDPOINT HERE>');`
    
16.  Save and exit by pressing Control + X, followed by Y, and hitting Enter.
    

### Modify Security Groups

1.  Return to your browser window or tab with the EC2  _Connect to instance_  page open.
2.  In the left-hand navigation menu, under  `Networks & Security`, click  `Security Groups`.
3.  Click the checkmark next to the non-default security group among those provided in the lab.
4.  Click the  **Inbound rules**  tab.
5.  Click the  **Edit inbound rules**  button.
6.  Click the  **Add rule**  button.
7.  For the new rule, from the  _Type_  dropdown menu, select  **MYSQL/Aurora**.
8.  In the dropdown menu to the right of the  **Source**  column for the new rule, find and select the non-default security group.
9.  Click  **Save rules**.

### Complete Wordpress Installation and Test

1.  Return to the terminal.
2.  At the bottom of the screen on the white bar, copy the public IP being shown after  _Public IPs_.
3.  Open a new browser window or tab, and paste it there.
4.  On the WordPress installation page, enter in the following information for each field:

-   _Site Title_: "A Cloud Guru"
-   _Username_: "guru"
-   _Password_: Select a strong password to use here, and make sure to copy it in your clipboard for later.
-   _Your Email_: "[test@test.com](mailto:test@test.com)"

1.  Click  **Install WordPress**.
2.  Click  **Log in**.
3.  Enter "guru" for the  _Username or email_  and paste in the password that you copied earlier.
4.  To view the website you just created, click  **A Cloud Guru**  in the top right corner of the page..
5.  Click  **Visit Site**  to visit your newly created WordPress site.

## Conclusion

Congratulations — you've completed this hands-on lab!


