
# Building a Serverless Application Using Step Functions, API Gateway, Lambda, and S3 in AWS

## Introduction

In this hands-on lab, you will create a fully working serverless reminder application using S3, Lambda, API Gateway, Step Functions, Simple Email Service, and Simple Notification Service. By the end of the lab, you will feel more comfortable architecting and implementing serverless solutions within AWS.

## Objectives
Create the Lambda Functions

Create a Step Function State Machine

Create the API Gateway

Create and Test the Static S3 Website

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Be sure to use an incognito or private browser window to ensure you’re using the lab account rather than your own.

**Note**: Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

Open the lab's  [GitHub repository](https://github.com/julielkinsfembotit/LALabs)  in a second tab. All of the code needed to complete this lab is available there.

### Create the Lambda Functions

1.  In the GitHub repo, click on the file,  `email_reminder.py`  to open it.
    
2.  Return to your first tab, and in the AWS Management Console, navigate to Lambda by typing  _Lambda_  in the search bar at the top of the screen. Select  **Lambda**  from the drop-down menu.
    
3.  In the AWS Lambda console, click  **Create function**.
    
4.  Leave the  **Author from scratch**  option selected, and then set the following values:
    
    -   **Function name:**  _email_
    -   **Runtime:**  **Python 3.8**
5.  Expand  **Change default execution role**  by clicking the arrow next to it.
    
6.  Below  **Execution role**, select  **Use an existing role**.
    
7.  Once you select that, click into the empty drop-down menu that appears below  **Existing role**.
    
8.  Select  **LambdaRuntimeRole**  from the drop-down menu.
    
9.  Click  **Create function**  at the bottom of the page.
    
10.  Scroll down to  **Code source**  and from the  **Environment**  file list on the left, click  `lambda_function.py`  to display the function code.
    
11.  Delete all of the provided code.
    
12.  Return to your other tab with the  `email_reminder.py`  file from the GitHub repo open.
    
13.  Click  **Raw**  above the code to display the raw function code.
    
14.  Copy all of the code to your clipboard.
    
15.  Return to the Lambda console in your first tab, and paste the copied code into  `lambda_function.py`.
    

#### Verify an Email Address in Simple Email Service (SES)

1.  Open Simple Email Service in a new tab by typing  _Simple Email Service_  into the search bar at the top of the screen. Right-click  **Amazon Simple Email Service**  from the drop-down menu, and select  **Open Link in New Tab**.
    
2.  In the Amazon Simple Email Service (SES) console, click  **Create identity**.
    
3.  On the  **Create identity**  page, under  **Identity type**, select  **Email address**.
    
4.  Under  **Email address**, enter your personal email address (or an email address you created specifically for this hands-on lab).
    
5.  Scroll down and click  **Create identity**.
    
6.  In a new browser tab or email client, navigate to your email, open the Amazon SES verification email, and click the provided link.
    
    > **Note:**  Check your spam mail if you do not see it in your inbox.
    
    You should see a  **Congratulations!**  page that confirms you successfully verified your email address.
    
7.  Return to the AWS SES console tab.
    
    You should now see  **Verified**  under  **Identity status**. (**Note:**  You may need to refresh the page.)
    

#### Finish the  `email`  Lambda Function Setup

1.  Return to the Lambda console in your first tab.
    
2.  Within the  `lambda_function`  code, on line 3, delete the  `YOUR_SES_VERIFIED_EMAIL`  placeholder, and type in the email you just used, making sure to leave the single quotes around it.
    
3.  Click  **Deploy**  in the  **Code source**  menu bar above the code.
    
    Your changes have now been deployed.
    
4.  Scroll up on the same page to the  **Function Overview**  section, and copy the  **Function ARN**  by clicking the copy icon next to it, and paste it into a text file for later use in the lab.
    

#### Create the  `sms`  Lambda Function

1.  In the navigation line at the top of the page, click  **Lambda**  to return to the main Lambda console.
    
2.  Click  **Create function**.
    
3.  Leave the  **Author from scratch**  option selected, and then set the following values:
    
    -   **Function name:**  _sms_
    -   **Runtime:**  **Python 3.8**
4.  Expand  **Change default execution role**  by clicking the arrow next to it.
    
5.  Below  **Execution role**, select  **Use an existing role**.
    
6.  Once you select that, click into the empty drop-down menu that appears below  **Existing role**.
    
7.  Select  **LambdaRuntimeRole**  from the drop-down menu.
    
8.  Click  **Create function**  at the bottom of the page.
    
9.  Scroll down to  **Code source**  and from the  **Environment**  file list on the left, click  `lambda_function.py`  to display the function code.
    
10.  Delete all of the provided code.
    
11.  Return to your GitHub repo tab, and click the back icon in your browser twice, to return to the main page of the repo.
    
12.  Click the  `sms_reminder.py`  file.
    
13.  Click  **Raw**  to display the raw function code.
    
14.  Copy all of the code to your clipboard.
    
15.  Return to the AWS Lambda console in your first tab, and paste the copied code into  `lambda_function.py`.
    
16.  Click  **Deploy**. Keep this tab open
    

#### Create the  `api_handler`  Lambda Function

1.  Scroll up to the navigation line at the top of the page, click  **Lambda**  to return to the main Lambda console.
    
2.  Click  **Create function**.
    
3.  Leave the  **Author from scratch**  option selected, and then set the following values:
    
    -   **Function name:**  _api_handler_
    -   **Runtime:**  **Python 3.8**
4.  Expand  **Change default execution role**  by clicking the arrow next to it.
    
5.  Below  **Execution role**, select  **Use an existing role**.
    
6.  Once you select that, click into the empty drop-down menu that appears below  **Existing role**.
    
7.  Select  **LambdaRuntimeRole**  from the drop-down menu.
    
8.  Click  **Create function**  at the bottom of the page.
    
9.  Scroll down to  **Code source**  and from the  **Environment**  file list on the left, click  `lambda_function.py`  to display the function code.
    
10.  Delete all of the provided code.
    
11.  Return to your GitHub repo tab, and click the back icon in your browser twice, to return to the main page of the repo.
    
12.  Click the  `api_handler.py`  file.
    
13.  Click  **Raw**  above the code to display the raw function code.
    
14.  Copy all of the code to your clipboard.
    
15.  Return to the AWS Lambda console in your first tab, and paste the copied code in to  `lambda_function.py`.
    
16.  Click  **Deploy**. Keep this tab open.
    

### Create a Step Function State Machine

1.  Open the AWS Step Functions console in a new tab by typing  _Step Functions_  into the search bar at the top of the screen. Right-click  **Step Functions**  from the drop-down menu, and select  **Open Link in New Tab**.
    
2.  In the AWS Step Functions console tab, click  **Get started**.
    
3.  In the line under the  **Review Hello World example**, click  **here**  at the end of the sentence to create your own step function.
    
    > **Note:**  If prompted with a  **Leave page?**  warning pop-up window, click  **Leave**, and then click  **here**  on the line under  **Review Hello World example**  again.
    
4.  On the  **Create state machine**  page, under  **Choose authoring method**, select  **Write your workflow in code**.
    
5.  Under  **Type**, leave  **Standard**  selected.
    
6.  Scroll down to  **Definition**  and delete all of the provided code.
    
7.  Return to your GitHub repo tab, and click the back icon in your browser twice, to return to the main page of the repo.
    
8.  Click the  `step-function-template.json`  file to open it.
    
9.  Click  **Raw**  above the code to display the raw function code.
    
10.  Copy all of the code to your clipboard.
    
11.  Return to the Step Functions console tab, and paste the code under  **Definition**.
    
12.  On lines 34 and 52, replace the  `EMAIL_REMINDER_ARN`  placeholder value with the copied ARN for  `email`  that you should have copied over onto a text file earlier, being sure to leave the double quotes around the ARN.
    
13.  On lines 40 and 62, replace the  `TEXT_REMINDER_ARN`  placeholder value with the copied ARN for  `sms`.
    
    -   Return to the Lambda console in your first tab.
    -   In the navigation line at the top of the page, click  **Functions**.
    -   Under  **Functions**, select  **sms**.
    -   Under  **Function overview**  on the right, copy the  **Function ARN**  to your clipboard by clicking the copy icon next to it.
    -   Return to your Step Functions console tab.
    -   Replace the two instances of  `TEXT_REMINDER_ARN`  on lines 40 and 62, being sure to leave the double quotes around the ARN.
    
    You should now see the updated function diagram show up to the right of the code.
    
14.  Click  **Next**  at the bottom of the screen.
    
15.  On the  **Specify details**  page, you can leave the default name, and under  **Permissions**, select  **Choose an existing role**.
    
16.  Leave the auto-populated,  **RoleForStepFunction**  under  **Existing roles**.
    
17.  Scroll down, and click  **Create state machine**.
    
    Your state machine should now be created.
    
18.  On the  **MyStateMachine**  page, under  **Details**, copy the ARN to your clipboard.
    
19.  Return to the Lambda console in your first tab.
    
20.  In the navigation line at the top of the page, click  **Functions**.
    
21.  Under  **Functions**, select the  **api_handler**  function.
    
22.  Scroll down to  **Code source**  and view the  `lambda_function.py`  code.
    
23.  On line 6, replace the  `STEP_FUNCTION_ARN`  placeholder with the ARN you just copied.
    
24.  Click  **Deploy**.
    

### Create the API Gateway

1.  Open the Amazon API Gateway console in a new tab by typing  _API Gateway_  into the search bar at the top of the screen. Right-click  **API Gateway**  from the drop-down menu, and select  **Open Link in New Tab**.
    
2.  In your Amazon API Gateway console tab, scroll down to  **REST API (the one that does not say Private)**, and then select  **Build**.
    
3.  In the  **Create your first API**  pop-up window, click  **OK**.
    
4.  Under  **Choose the protocol**, leave  **REST**  selected.
    
5.  Under  **Create new API**, select  **New API**.
    
6.  Under  **Settings**, set the following values:
    
    -   **API name:**  _reminders_
    -   Leave  **Description**  blank.
    -   **Endpoint Type:**  _Regional_
7.  Click  **Create API**  at the bottom of the screen.
    
    You should now be in your API Gateway, and you will see that you don't have any methods defined for the resource.
    
8.  Click on the  **/**  under  **Resources**.
    
9.  Click  **Actions**  >  **Create Resource**.
    
10.  On the  **New Child Resource**  page, next to  **Resource Name**, enter  _reminders_, which will also auto-populate  `/reminders`  as the  **Resource Path**.
    
11.  Select the checkbox next to  **Enable API Gateway CORS**.
    
12.  Click  **Create Resource**  at the bottom of the page.
    
13.  Then, click  **/reminders**, and click  **Actions**  >  **Create Method**.
    
14.  In the dropdown that appears under  **/reminders**, select  **POST**  and click the adjacent checkmark icon.
    
15.  Under  **/reminders - POST - Setup**, set the following values:
    
    -   **Integration type:**  **Lambda Function**
    -   **Use Lambda Proxy integration:**  Select the checkbox.
    -   **Lambda Region:**  **us-east-1**
    -   **Lambda Function:**  Start typing, and then select,  _api_handler_.
16.  Click  **Save**  at the bottom of the page
    
17.  In the  **Add Permission to Lambda Function**  pop-up window, click  **OK**.
    
18.  Click  **Actions**  >  **Deploy API**.
    
19.  In the  **Deploy API**  pop-up window, set the following values:
    
    -   **Deployment stage:**  **[New Stage]**
    -   **Stage name:**  _prod_
20.  Click  **Deploy**.
    
    > **Note:**  You may ignore any Web Application Firewall (WAF) permissions warning messages if received after deployment.
    
21.  At the top of the page, under  **prod Stage Editor**, copy the  **Invoke URL**  and paste it into a text file for later use in the lab..
    

### Create and Test the Static S3 Website

1.  Return to your GitHub repo tab, and click the back icon in your browser twice, to return to the main page of the repo.
    
2.  Click  **Code**  in the top right above the files in the repo, and select  **Download ZIP**  to download all of the files in the repo.
    
3.  Unzip and open the downloaded file, and then open your local  `static_website`  folder.
    
4.  Open the  `formlogic.js`  file in a text editor.
    
5.  On line 5 of  `formlogic.js`, delete the  `UPDATETOYOURINVOKEURLENDPOINT`  placeholder. Paste in the  **Invoke URL**  you previously copied from API Gateway, being sure to keep  `/reminders`  on the end of the string.
    
6.  Save the local file.
    
7.  Return to your first AWS Management Console tab.
    
8.  Open the Amazon S3 console in a new tab by typing  _S3_  into the search bar at the top of the screen. Right-click  **S3**  from the drop-down menu, and select  **Open Link in New Tab**.
    
9.  In the Amazon S3 console, click  **Create bucket**.
    
10.  On the  **Create bucket**  page, under  **Bucket name**, enter a globally unique bucket name.
    
11.  Under  **Object Ownership**, select  **ACLs enabled**, and ensure  **Bucket owner preferred**  is selected.
    
12.  Uncheck  **Block  _all_  public access**.
    
13.  Under  **Block  _all_  public access**, select  **I acknowledge that the current settings might result in this bucket and the objects within becoming public.**
    
14.  Leave the other defaults, scroll down, and click  **Create bucket**.
    
15.  Select the new bucket under  **Buckets**  to open it.
    
16.  On the bucket page, click  **Upload**.
    
17.  On the  **Upload**  page, click  **Add files**  and select all of your local files from the  `static_website`  folder, and click  **Open**. Or, drag all of your local files from the  `static_website`  folder into the  **Drag and drop**  box under  **Upload**.
    
    -   `cat.png`
    -   `error.html`
    -   `formlogic.js`
    -   `IMG_0991.jpg`
    -   `index.html`
    -   `main.css`
18.  Once all six of the files have been added, scroll down, and click  **Permissions**  to expand the access options.
    
19.  Under  **Predefined ACLs**, select  **Grant public-read access**.
    
20.  Under  **Grant public-read access**, select  **I understand the risk of granting public-read access to the specified objects.**
    
21.  Click  **Upload**  at the bottom of the page.
    
22.  Once you see the uploads have succeeded, click  **Close**  in the top right-hand corner of the page.
    
23.  Click on the  **Properties**  tab under the bucket name.
    
24.  Scroll down to  **Static website hosting**, and click  **Edit**.
    
25.  On the  **Edit static website hosting**  page, under  **Static website hosting**, select  **Enable**.
    
26.  Set the following values:
    
    -   **Index document:**  _index.html_
    -   **Error document:**  _error.html_
27.  Click  **Save changes**  at the bottom of the page.
    
28.  Scroll down again to  **Static website hosting**, and click the URL below  **Bucket website endpoint**  to access the webpage.
    
29.  Once you are on the static website, to test the service's functionality, set the following values:
    
    -   **Seconds to wait:**  _1_
    -   **Message:**  _Hello!_
    -   _[someone@something.com](mailto:someone@something.com):_  Your personal email address (This has to be the same one you verified with Simple Email Service earlier.)
30.  Under  **Reminder Type**, select  **email**.
    
    You should see  **Looks ok. But check the result below!**  above the  **Required sections**, and you should see  `{"Status":"Success"}`  at the bottom of the page.
    
31.  In a new browser tab or email client, navigate to your email. You should now see a reminder email from the service.
    
    > **Note**: Check your spam folder if you do not see it in your inbox.
    
32.  Navigate to your AWS Step Functions console tab.
    
33.  In the  **Executions**  section, click on the refresh icon.
    
    You should see at least one execution displayed.
    
34.  Click on one of the executions.
    
35.  Scroll down to  **Graph inspector**  to view the event's visual workflow.
    

## Conclusion

Congratulations — you've completed this hands-on lab!
