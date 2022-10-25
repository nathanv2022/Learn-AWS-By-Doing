
# Creating and Subscribing to AWS SNS Topics

## Introduction

In this live AWS environment, you will be using the AWS Simple Notification Service (SNS). You will create an SNS topic and then subscribe to that topic using multiple endpoints (SMS, email, and AWS Lambda). This environment will allow you to demonstrate successful interaction with the SNS service by creating SNS topics and adding subscribers to those topics. At the end of this activity, you will have demonstrated you have a basic understanding of the SNS service, the components within it, and how to use the service in the AWS console.

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Please ensure you are using the  **us-east-1**  (N. Virginia region) region.

This lesson's  [GitHub repo](https://github.com/linuxacademy/aws-cda-2018/tree/master/sns/lab-files).

> **Note:**  When creating the Lambda subscription, you will have to close the permission errors that appear. Afterward, you will be able to continue and finish the lab.

Additionally, please delete your email in the SNS section before closing the lab.

### Create an SNS Topic

1.  Click on the  **Services**  drop-down menu and select  **Simple Notification Service**  from the list. (Or, simply search for  **SNS**  in the  **Search**  bar.)
    
2.  In the  **Create topic**  box on the landing page, type "mytopic" and click  **Next step**.
    
3.  On the  **Create topic**  page, select the  **Type**  as  **Standard**
    
4.  Make sure your topic name is set to  **mytopic**.
    
5.  In the  **Display name**  field, type "My Topic".
    
6.  Scroll down and click  **Create topic**
    
7.  On the  **Subscriptions**  tab, click the  **Create subscription**  button, and set the following:
    
    -   **Topic ARN:**  Leave it at the default or select the only option available in the drop-down
    -   **Protocol:**  Select  **Email**
    -   **Endpoint:**  Enter your email address
8.  Click  **Create subscription**. This may take some time to provision.
    
9.  Check your email, including your  **Spam**  folder, for a confirmation email. Once received, click  **Confirm subscription**  in the email.
    
10.  Create another subscription, this time for SMS. Click  **Subscriptions**  in the left menu, click the  **Create subscription**  button, and set the following:
    
    -   **Topic ARN:**  Select the only option available in the drop-down
        
    -   **Protocol:**  Select  **SMS**
        
    -   **Endpoint:**  Enter your phone number
        
        > **Note:**  You may need to verify your phone number in the sandbox before you are able to add it as an endpoint. If so, click the  **Add phone number**  button and follow the prompts to verify your phone number.
        
11.  Click  **Create subscription**. Keep this tab open.
    

### Create a Lambda Function

1.  Open another instance of the AWS Management Console in a new private browser tab.
    
2.  Click on the  **Services**  drop-down menu and select  **Lambda**  from the list. (Or, simply search for  **Lambda**  in the  **Search**  bar.)
    
3.  Click the  **Create function**  button and set the following:
    
    -   Select the  **Author from scratch**  option
    -   **Function name:**  Type "SNSProcessor"
    -   **Runtime:**  Select  **Python 3.6**
4.  Expand the  **Change default execution role**  section and set the following:
    
    -   **Execution role:**  Select  **Use an existing role**
    -   **Existing role:**  Select  **LambdaRoleLA**
5.  Click  **Create function**.
    
6.  Navigate back to the SNS browser tab and create another subscription for the Lambda function. Click  **Subscriptions**  in the left menu, click the  **Create subscription**  button, and set the following:
    
    -   **Topic ARN:**  Select the only option available in the drop-down
    -   **Protocol:**  Select  **AWS Lambda**
    -   **Endpoint:**  Select the only option available in the drop-down
7.  Click  **Create subscription**.
    
8.  Navigate back to the Lambda function browser tab and paste the following code into the code source, replacing the existing code:
    
    `def lambda_handler(event, context): message = event['Records'][0]['Sns']['Message'] print("From SNS: " + message) return message`
    
9.  Click  **Deploy**.
    

### Send Your SNS Topic to Multiple Endpoints

1.  Navigate back to the SNS browser tab and click  **Topics**  in the left menu.
    
2.  Select  **mytopic**, click the  **Publish message**  button, and set the following:
    
    -   **Subject:**  Type "An AWS Topic"
    -   **Message body to send to the endpoint:**  Type "Hello, this is our first message."
3.  Scroll down and click  **Publish message**.
    
4.  If successful, you'll receive an email and a text message with the content you configured.
    
5.  Navigate back to the Lambda browser tab and click on the  **Monitor**  tab.
    
6.  Click the  **View logs in CloudWatch**  button. If successful, you will see a message entry in the  **Log streams**  section.
    

> **Note:**  Please delete your email from the SNS section before ending the lab.

## Conclusion

Congratulations — you've completed this hands-on lab!
