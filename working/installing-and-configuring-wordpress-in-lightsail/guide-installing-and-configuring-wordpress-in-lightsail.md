
# Installing and Configuring Wordpress in Lightsail

## Description

In this learning activity, we will use Amazon Lightsail to create a simple Wordpress blog.

The goal of this activity is to gain experience with:

-   Creating a Lightsail instance with pre-installed applications
-   Connecting to instances using the web console or local SSH client
-   Creating and attaching static IP addresses to instances
-   Diagnosing and updating network restrictions that apply to instances

These objectives will help us build a foundation for more advanced Lightsail use.

## Objectives

Successfully complete this lab by achieving the following learning objectives:

### Create a Lightsail instance using the Wordpress blueprint.

1.  Create a Lightsail instance using the Wordpress blueprint.
2.  Select the  `2 GB`  memory instance size.

-   Connect to the instance using SSH and obtain the Wordpress admin password.
-   Using the admin password, connect to  [http://instanceip/wpadmin](http://instanceip/wpadmin)  and create a blog post.
-   Navigate to  [http://instanceip](http://instanceip/)  and ensure you can see the post.

### Allocate a static IP for the instance.

1.  Create and attach a static IP address to the instance.
2.  Confirm visually and functionally that the IP address is static.
3.  Navigate to  [http://instancestaticip](http://instancestaticip/)  to ensure the IP address is functional.

### Prune the network firewall to allow only essential ports.

1.  Disallow SSH connectivity to the Wordpress instance.
2.  Disallow HTTPS connectivity to the Wordpress instance.

### Tidy up networking and delete the instance.

1.  Detach and remove the Wordpress instance's static public IP.
2.  Delete the Wordpress instance.
