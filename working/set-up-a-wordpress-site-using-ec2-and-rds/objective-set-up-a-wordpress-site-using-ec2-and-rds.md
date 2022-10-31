# Set Up a WordPress Site Using EC2 and RDS


## Description

Amazon Relational Database Service (Amazon RDS) allows users to easily create, operate, and scale a relational database in the cloud. In this lab, we create an RDS database, install a web server and configure WordPress to connect to the RDS database. We then run the final configuration through the web browser and are presented with a working WordPress blog. By the end of this lab, the user will understand how to create an RDS database and configure WordPress to use it to store data.

## Objectives
Successfully complete this lab by achieving the following objectives:

### Create RDS Database

Using the AWS console, create an RDS database with the following configurations:

-   Choose a database creation method:  `Standard create`
-   _Engine options_:  `MySQL`
-   _Edition_:  `MySQL Community`
-   _Version_:  `MySQL 8.0.28`
-   _Templates_:  `Free tier`
-   _DB instance class_:  `db.t2.micro`
-   _DB instance identifier_:  `wordpress`

### Install Apache and Dependencies

Connect to your  **Cloud Server webserver-01**  and perform the following tasks:

-   Use the  _apt_  command to install:  `apache2`  `libapache2-mod-php`  `php-mysql`
-   Move the  `/wordpress`  folder into your  `/var/www`  directory
-   Move your  `/var/www/wordpress/000-default.conf`  file to  `/etc/apache2/sites-enabled/`
-   Restart  `apache2ctl`

### Configure WordPress

Configure  `wp-config.php`  to connect to the RDS database we created.

-   Edit your  `/var/www/wordpress/wp-config.php`  file and replace  `'localhost'`  by your own RDS endpoint on the line  `define('DB_HOST', 'localhost');`
-   Save and close the file

### Modify Security Groups

Modify your non-default security group to allow the EC2 instance to connect to the MySQL/Aurora RDS database.

### Complete Wordpress Installation and Test

Visit the website and complete the installation, ensuring the website can be visited and the WordPress portal works.


