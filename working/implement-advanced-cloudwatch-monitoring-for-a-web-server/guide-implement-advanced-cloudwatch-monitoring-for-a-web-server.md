
# Implement Advanced CloudWatch Monitoring for a Web Server


## Description

CloudWatch Logs centralizes the logs from all of your systems, applications, and AWS services that you use, in a single, highly scalable service. In this lab, you will configure an EC2 instance to stream its Apache web server error logs to CloudWatch Logs. You will configure the agent and then log in to the CloudWatch Logs console to make sure the logs are streamed correctly. By the end of this lab, you will understand how to install the CloudWatch Logs agent and configure it to stream a log to the service.

## Objectives

### Download and Run the CloudWatch Logs Installer

Connect to the  `webserver-01`  instance, and install the CloudWatch Logs agent:

`wget -O awslogs-agent-setup.py https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py`

`sudo python ./awslogs-agent-setup.py --region us-east-1`

### Configure CloudWatch Logs

Follow the prompts to configure CloudWatch Logs, including opening the IAM console to generate an access key and secret key.

Copy and paste the below path for the log file to upload:  `/var/log/apache2/error.log`

### Log in to the CloudWatch Logs Website

Open the CloudWatch Logs website to observe if the log has streamed correctly.

Also view the contents of the error log in the CLI via:  `sudo cat /var/log/apache2/error.log`

## Solution

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  `us-east-1`  Region.

### Download and Run the CloudWatch Logs Installer

1.  From the AWS Management Console, navigate to EC2.
    
2.  Select  **Instances (running)**.
    
3.  Select  **webserver-01**.
    
4.  At the top, click  **Connect**.
    
5.  At the bottom of the page, click  **Connect**  to access the CLI.
    
6.  Run the following commands to install the CloudWatch Logs agent:
    
    `wget -O awslogs-agent-setup.py https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py`
    
    `sudo python ./awslogs-agent-setup.py --region us-east-1`
    

### Configure CloudWatch Logs

1.  Go back to the AWS Management Console, and open IAM in a separate tab.
    
2.  Click  **Users**.
    
3.  Click  **cloud_user**.
    
4.  Select the  **Security credentials**  tab.
    
5.  Click  **Create access key**.
    
6.  Copy the  **Access key ID**.
    
7.  Go back to the CLI (keep IAM open in the other tab). When prompted, paste the AWS Access Key ID.
    
8.  Go back to IAM to show and copy the  **Secret access key**.
    
9.  Go back to the CLI, and paste the Secret Access Key.
    
10.  Press  **Enter**  twice to accept the default region name and output format.
    
11.  Copy and paste the below path for the log file to upload:
    
    `/var/log/apache2/error.log`
    
12.  Press  **Enter**  to keep the current Destination Log Group name.
    
13.  Press  **Enter**  to accept the default Log Stream name.
    
14.  Press  **Enter**  to keep the default Log Event timestamp format.
    
15.  Press  **Enter**  to select  _From start of file_  as the initial position of upload.
    
16.  Type  `N`  to complete the configuration.
    

### Log in to the CloudWatch Logs Website

1.  Copy the link provided in the CLI output, and open it in a new browser tab to begin accessing new log events. Make sure to include the ending  `:`.
    
2.  Click  `/var/log/apache2/error.log`.
    
3.  Under  _Log streams_, click the link for the instance identifier. You will see the contents of your error log with two events logged.
    
4.  You can also view the contents of the error log in the CLI by running the following command:
    
    `sudo cat /var/log/apache2/error.log`
    

## Conclusion

Congratulations on successfully completing this hands-on lab!
