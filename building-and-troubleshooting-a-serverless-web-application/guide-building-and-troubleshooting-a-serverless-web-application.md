
# Building and Troubleshooting a Serverless Web Application

## Introduction

In this hands-on lab, we are going to build and troubleshoot a serverless web application using the following technologies:

-   DynamoDB
-   Lambda
-   API Gateway
-   S3
-   X-Ray

## OBJECTIVES

Create a DynamoDB Table

Create a Lambda Function with an API Gateway Endpoint

Create an S3 Bucket and Upload the Website Files

Configure X-Ray

Review The X-Ray Service Map

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  _us-east-1_  Region.

### Create a DynamoDB Table

1.  Open the AWS CLI by clicking on the CloudShell button in top-right corner.
    
2.  Click  **Close**  on the  **Welcome to AWS CloudShell**  pop-up.
    
3.  Look in the top-right corner to confirm you are in the  **N. Virginia**  Region.
    
4.  Clone the Git repository:
    
    `git clone https://github.com/ACloudGuru/hands-on-aws-troubleshooting/`
    
5.  Change to the correct directory:
    
    `cd hands-on-aws-troubleshooting/`
    
6.  Change directory again:
    
    `cd Building_and_Troubleshooting_a_Serverless_Web_Application/`
    
7.  List the files:
    
    `ls`
    
8.  Create the DynamoDB table and populate it:
    
    `aws dynamodb create-table --table-name fortunes --attribute-definitions \ AttributeName=fort_id,AttributeType=N --key-schema \ AttributeName=fort_id,KeyType=HASH \ --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5`
    

> **Note:**  If you're using Windows, replace  `\`  with  `^`  character (Shift + 6)

> **Note:**  You can find the command in the  [GitHub repository](https://github.com/ACloudGuru/hands-on-aws-troubleshooting)  >  `Building_and_Troubleshooting_a_Serverless_Web_Application/`  >  `dynamodb_commands.txt`  > underneath  `1) Create fortunes table:`

1.  In the  **Safe Paste for multiline text**, click  **Paste**.
    
2.  Press  **Enter**.
    
3.  Clear the screen:
    
    `clear`
    
4.  Navigate to the  `items.json`  folder:
    
    `cat items.json`
    
5.  `clear`  the screen.
    
6.  Populate the fortunes table (this command can be found in  [`dynamodb_commands.txt`](https://github.com/ACloudGuru/hands-on-aws-troubleshooting/blob/main/Building_and_Troubleshooting_a_Serverless_Web_Application/dynamodb_commands.txt)):
    
    `aws dynamodb batch-write-item --request-items file://items.json`
    
7.  You should see the  `"UnprocessedItems"`  message if the table was successfully populated.
    

### Create a Lambda Function with a Function Endpoint

1.  Navigate to the  [GitHub repository](https://github.com/ACloudGuru/hands-on-aws-troubleshooting/tree/main/Building_and_Troubleshooting_a_Serverless_Web_Application)  >  `lambda_function.py`  and review the code making up the function.
2.  Click  **Raw**  in the top-right corner.
3.  Copy the code and navigate back to the AWS CLI.
4.  Click  **Services**  in the top-left corner and in the  **Search**  bar at the top, enter  _Lambda_.
5.  Right-click  **Lambda**  and open it in a new tab.
6.  In the Lambda console, click  **Create function**  in the top-right corner.
7.  Under  **Basic Information**, set the following values:
    -   **Function name**:  _mylambdafunction_
    -   **Runtime**: select the latest supported version of  **Python**  available (e.g.,  **Python 3.9**)
8.  Click  **Create function**.
9.  Scroll down and delete the code listed in the  `lambda_function`  code editor.
10.  Paste in the previously copied code (i.e., the  `lambda_function.py`  code).
11.  Click  **Deploy**  at the top.
12.  Click  **Test**.
13.  Under  **Configure test event**, set the following values:
    -   **Test event action**:  **Create new event**
    -   **Event name**:  _te1_
14.  Leave the other settings as default and click  **Save**.
15.  Click  **Test**  to run.

> **Note:**  If you see a  `timeout`  error, click  **Test**  again until you see the  `AccessDeniedException`  error.

1.  Under  `Response`, review the  `AccessDeniedException`  error.
2.  Click on  **Configuration**  above  **Code source**.
3.  Under the  **General configuration**  menu on the left, select  **Permissions**.
4.  Under  **Execution role**  >  **Role name**, click on the Lamda execution role.
5.  Under  **Permissions policies**, Select  **Add permissions**  >  **Attach policies**.
6.  Under  **Other permissions policies**, enter  _dynamodb_  in the search bar.
7.  Click on the checkbox next to  **AmazonDynamoDBReadOnlyAccess**.
8.  Click  **Attach policies**.
9.  Navigate back to the  **mylambdafunction - Lambda**  browser tab.
10.  Navigate to the  **Code**  tab.
11.  Click  **Test**.
12.  You should see  `statusCode": 200`.
13.  Click on  **Configuration**  above  **Code source**.
14.  Under the  **General configuration**  menu on the left, select  **Function URL**.
15.  Click  **Create function URL**.
16.  Under  **Configure Function URL**, set the following value:
    -   **Auth type**:  **NONE**
17.  Scroll down and click  **Save**.
18.  Under  **Description**  in the top right, copy the  **Function URL**  and paste it in a new browser tab.

### Create an S3 Bucket and Upload the Website Files

1.  In the AWS CloudShell, ensure you're in the correct directory (you should see the following files:  `index.html`,  `error.html`,`cookie.jpg`, etc.):
    
    `ls`
    
2.  Use the  `vi`  editor to modify the  `index.html`  file. You can review the  [Vi Editor cheat sheet here](https://web.mit.edu/merolish/Public/vi-ref.pdf).
    
    `vi index.html`
    
3.  Scroll down, then press the  **esc**  key +  **j**. You should see your cursor move down every time you type  **j**.
    
4.  Move down until you get to the line containing  `xhttp.open`.
    
5.  Press the  **esc**  key +  **l**  to move your cursor until you reach the first letter of the API gateway string within the quotation marks.
    
6.  Press the  **esc**  key +  **x**  to delete the entire string. Once you've deleted the string, it should look like this:  `xhttp.open("GET", "", true);`
    
7.  Press the  **esc**  key +  **i**  to enter insert mode.
    
8.  Navigate to  **mylambdafunction - Lambda**  browser tab.
    
9.  Under  **Description**, copy the  **Function URL**.
    
10.  Navigate to back to the AWS CloudShell and paste the function URL within the quotation marks. It should look like this:  `xhttp.open("GET", "<FUNCTION_URL>", true);`.
    
11.  Press the  **esc**  key +  `:wq!`.
    
12.  Press  **Enter**.
    

#### Create an S3 Bucket with Public Access Enabled

1.  Navigate to  **mylambdafunction - Lambda**  browser tab.
    
2.  In the  **Search**  bar at the top, enter and select  **S3**.
    
3.  Click  **Create bucket**  and set the following values:
    
    -   **Bucket name**:  _mywebsitefilesXXX_  with random characters replacing  _XXX_  to ensure the bucket name is unique
    -   Deeselect  **Block  _all_  public access**
        -   Select the box next to  **I acknowledge that the current settings might result in this bucket and the objects within becoming public**  for the  **Turning off block all public access might result in this bucket and the objects within becoming public**  warning.
4.  Leave the other settings as default and click  **Create bucket**.
    
5.  Select your bucket and navigate to the  **Permissions**  tab.
    
6.  Click  **Edit**  next to  **Bucket policy**.
    
7.  Paste in the the following policy:
    
    `{ "Version": "2012-10-17", "Id": "Policy1650555565088", "Statement": [ { "Sid": "Stmt1650555563210", "Effect": "Allow", "Principal": "*", "Action": "s3:GetObject", "Resource": "arn:aws:s3:::mywebsitefiles6754376825/*" } ] }`
    
8.  Copy the bucket ARN shown above  **Policy**.
    
9.  Replace the  `Resource`  string within the quotation marks with the bucket ARN:  `"Resource": "<BUCKET_ARN>/*"`
    

> **Note:**  Make sure  `/*`  is after the bucket ARN

1.  Click  **Save changes**.
2.  You should see  **Publicly accessible**  under the bucket name.

#### Upload Three Files to the S3 Bucket

1.  Navigate back to the AWS CloudShell and ensure you're in the correct directory; you should see the following files:  `index.html`,  `error.html`,`cookie.jpg`, etc.:
    
    `ls`
    
2.  Locate the name of your bucket:
    
    `aws s3 ls`
    
3.  Copy the  `index.html`  file to the bucket:
    
    `aws s3 cp index.html s3://<BUCKET_NAME>`
    
4.  Repeat the above step with the  `error.html`  and  `cookie.jpg`  objects. Replace  `index.html`  with the name of each item:  `aws s3 cp <OBJECT> s3://<BUCKET_NAME>`. All three objects should be uploaded to your bucket.
    
5.  Navigate back to  **S3 Management Console**  browser tab.
    
6.  Click on your bucket under  **Buckets**  to open it.
    
7.  You should see  `index.html`,  `error.html`, and  `cookie.jpg`.
    

#### Configure S3 Static Website Hosting on Your S3 Bucket and Confirm It’s Accessible from the S3 Website-Hosting URL

1.  Navigate to the  **Properties**  tab.
2.  Scroll all the way down to  **Static website hosting**.
3.  Click  **Edit**.
4.  Under  **Static website hosting**, select  **Enable**, then set the following values:
    -   **Index document**:  _index.html_
    -   **Error document**:  _error.html_
5.  Click  **Save changes**.
6.  Scroll all the way down to  **Static website hosting**  and copy the bucket website endpoint.
7.  Paste the website endpoint in a new browser tab. You should see  **Hello Cloud Gurus! Welcome to The Calorie Free Serverless Fortune Cookie**.
8.  Select  **Click here to learn your fortune!**  to receive a fortune.

### Configure X-Ray

1.  Navigate to the  **mylamdafunction - Lambda**  browser tab and click on your function (**Lambda**  >  **Functions**  >  **mylambdafunction**).
    
2.  Click  **Configuration**  at the top.
    
3.  Select  **Monitoring and operations tools**  in the left menu.
    
4.  Select  **Edit**.
    
5.  Under  **AWS X-Ray**, enable  **Active tracing**.
    
6.  Scroll down and click  **Save**.
    
7.  Navigate to the  [GitHub repository](https://github.com/ACloudGuru/hands-on-aws-troubleshooting/tree/main/Building_and_Troubleshooting_a_Serverless_Web_Application)  >  `layer.zip`.
    
8.  On your local machine, clone the repository:
    
    `git clone https://github.com/ACloudGuru/hands-on-aws-troubleshooting`
    
9.  Move into the correct directory:
    
    `cd hands-on-aws-troubleshooting`
    
10.  Move into the correct directory:
    
    `cd Building_and_Troubleshooting_a_Serverless_Web_Application`
    
11.  `clear`  your screen.
    
12.  List the files. You should see the  `layer.zip`  file:
    
    `ls`
    
13.  Navigate to the  **mylamdafunction - Lambda**  browser tab.
    
14.  Click on the hamburger icon in the top-left corner to open the menu.
    
15.  Under  **Additional resources**, select  **Layers**.
    
16.  Click  **Create layer**.
    
17.  Under  **Name**, enter  _myLambdaLayer_.
    
18.  Ensure  **Upload a .zip file**  is selected.
    
19.  Click  **Upload**  and upload the  `layer.zip`  file.
    
20.  Under  **Compatible architectures**, click on the dropdown menu and select the latest supported version of  **Python**  available (e.g.,  **Python 3.9**).
    
21.  Click  **Create**.
    
22.  Click on the hamburger icon in the top-left corner to open the menu and select  **Functions**.
    
23.  Click on your Lambda function to open it.
    
24.  Under  **Function overview**, select  **Layers**.
    
25.  Under  **Layers**, select  **Add a layer**.
    
26.  Under  **Choose a layer**, select  **Custom layers**.
    
27.  Under  **Custom layers**, click on the dropdown menu and select your layer.
    
28.  Under  **Version**, select the only one listed.
    
29.  Click  **Add**.
    
30.  Scroll down until you see  **Code source**.
    
31.  Under the  `import`  section, create a new line.
    
32.  Navigate to the  [GitHub repository](https://github.com/ACloudGuru/hands-on-aws-troubleshooting/tree/main/Building_and_Troubleshooting_a_Serverless_Web_Application)  and click on  `lambda_function_xray.py`.
    
33.  Click  **Raw**  in the top-right corner.
    
34.  Copy the code.
    
35.  In the new space under  `import`  section, paste in the code. Make sure the code correctly lines up.
    
36.  Click  **Deploy**.
    
37.  Click  **Test**.
    
38.  Review the  `errorMessage`.
    

#### Fix the Timeout Error

1.  Click on  **Configuration**  at the top.
2.  In the left menu, click  **General configuration**  and review the timeout.
3.  Click  **Edit**.
4.  Under  **Timeout**, change the seconds to  _10_  (leave minutes at  _0_).
5.  Scroll down and click  **Save**.
6.  Select the  **Test**  tab and click  **Test**. You should see that the test was successful.
7.  Click  **Details**  to review the  `statusCode`  and function response.

### Review the X-Ray Service Map and Generated Traces

1.  Navigate to the  **Hello Cloud Gurus! Welcome to The Calorie Free Serverless Fortune Cookie**  website browser tab. (You can also locate the URL under  **S3 Management Console**  >  **Properties**  > scroll all the way down to  **Static website hosting**, and copy/paste the bucket website endpoint in a new browser tab.)
2.  Generate traffic to the website by clicking  **Click here to learn your fortune!**  a few times.
3.  Navigate to the  **mylamdafunction - Lambda**  browser tab.
4.  Select the  **Monitor**  tab.
5.  Select  **Traces**.
6.  Review the  **Service Map**  for activity. You can zoom in/out by clicking the magnifying glass icons on the right.
7.  Scroll down review the activity under  **Traces**.

#### Introduce (Then Fix) an Error in the DynamoDB Access from the Lambda Execution Role

1.  Scroll up and click on the  **Configuration**  tab.
2.  Select  **Permissions**  in the left-hand menu.
3.  Under  **Execution role**, right-click on the listed role and open it in a new tab.
4.  Under  **Permissions policies**, select the checkbox for  **AmazonDynamoDBReadOnlyAccess**.
5.  Click  **Remove**  in the top right corner.
6.  Click  **Delete**  in the pop-up that appears.
7.  Navigate back to the  **Hello Cloud Gurus! Welcome to The Calorie Free Serverless Fortune Cookie**  website browser tab.
8.  Click  **Click here to learn your fortune!**. No new fortune will generate.
9.  Navigate to the  **mylamdafunction - Lambda**  browser tab.
10.  Click on the  **Test**  tab.
11.  Next to  **Test event**, click  **Test**.
12.  You should see the  **Execution result: failed**  message. Repeat the above step to ensure the event is recorded in X-Ray.
13.  Click on the  **Monitor**  tab.
14.  Scroll down to see the  **Service Map**.
15.  Select  **fortunes DynamoDB Table**  within the service map.
16.  You should see an error between  **mylambdafunction Lambda Function**  and  **fortunes DynamoDB Table**.
17.  Scroll down to  **Traces**  and click on one of the traces with a  **Trace status**  of  **Error**. It will take you to the CloudWatch console.
18.  In the CloudWatch console, scroll down to  **Segments Timeline**  and click the  **DynamoDB Fault**  status.
19.  Under  **Segment details: DynamoDB**, click  **Exceptions**  to view the details of the error.
20.  Navigate to the  **IAM Management Console**  browser tab >  **Roles**  > select your Lambda function execution role.
21.  Next to  **Permissions policies**, click  **Add permissions**  >  **Attach policies**.
22.  In the  **Search**  bar under  **Other permissions policies**, enter  _dynamo_.
23.  Select the checkbox next to  **AmazonDynamoDBReadOnlyAccess**.
24.  Click  **Attach policies**.

> **Note:**  You can ignore the permissions error message.

1.  Navigate to the  **Hello Cloud Gurus! Welcome to The Calorie Free Serverless Fortune Cookie**  website browser tab.
2.  Click  **Click here to learn your fortune!**.

#### Introduce an Error in the Lamba Code

1.  Navigate to the  **IAM Management Console**  browser tab.
2.  In the  **Search**  bar at the top, enter and select  **Lambda**.
3.  Under  **Functions**, click on the function listed.
4.  Click on the  **Code**  tab.
5.  Under  **Code source**, locate  `table = dynambodb.Table('fortunes')`.
6.  Remove the letter  `s`  in  `fortunes`.
7.  Click  **Deploy**.
8.  Click  **Test**. You should see an error.
9.  Navigate to the  **Hello Cloud Gurus! Welcome to The Calorie Free Serverless Fortune Cookie**  website browser tab and click  **Click here to learn your fortune!**. No new fortune will generate.
10.  Navigate back to the  **mylamdafunction - Lambda**  browser tab.
11.  Select the  **Monitor**  tab.
12.  Review the  **Service Map**. You should see a new DynamoDB table named  **fortune**.
13.  Click on the  **fortune**  table and review the error message that appears between  **mylambdafunction Lambda Function**  and the  **fortune**  table.
14.  Click  **View traces**.
15.  Scroll down to  **Traces**.
16.  Click on one of the traces with a  **Response code**  of  **502**.
17.  Click the  **DynamoDB Fault**  status.
18.  Under  **Segment details: DynamoDB**, click  **Exceptions**  to view the details of the error.

## Conclusion

Congratulations — you've completed this hands-on lab!

## Tools

[](https://labkeep-assets-production.s3.amazonaws.com/xs30uhsjbd0sij3lt5g4z7ipc1yo?response-content-disposition=inline%3B%20filename%3D%22BUILDING_AND_TROUBLESHOOTING_A_SERVERLESS_WEB_APPLICATION_LAB_DIAGRAM.001.png%22%3B%20filename%2A%3DUTF-8%27%27BUILDING_AND_TROUBLESHOOTING_A_SERVERLESS_WEB_APPLICATION_LAB_DIAGRAM.001.png&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=ASIAVKPCGNLNUJWLU3Q2%2F20221027%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20221027T010259Z&X-Amz-Expires=300&X-Amz-Security-Token=IQoJb3JpZ2luX2VjECAaCXVzLWVhc3QtMSJGMEQCIHLgG4qdySWFX9T7%2F17WH5Z9Ew%2BqfeIYiMx3PpMxcsDSAiAGm0oF%2BIJxv0Xu6D10EQ4SijYQ90loF7QfHdEhbUsKdiqMBAj4%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAIaDDM2NjA4MzQ2Nzk5NSIM0M5bhcRP3W1pwoW0KuADrUWSGJuwZUX3dQYlA1GukplfMjbKt7Ctu0ySXVkJEqpBviuZdJ6YYyg2PpoiJTvvWlgJpVrvO5ohkGAXQggk5yFXBnyepso2h%2BMjMSVeohTQPgRcrYIdpBFcFGai3aNJofVHxWFp%2BZfFVmGj0o6wcfmQnBCnwXC6I9484p4Dp%2BY5lOpwiUYvmvdqsLGeT2ehF%2F6jSGX2PsV5fdMqZxq8Lad%2FZrYrvAqEd2Zs6KZNCUUcAHQG4eUUN9OgPPSCeowVgvGBrc3GC8wWpTujxFn1A152DUnbGNw6HUoMjQ8fC1ERg3eV6mqZpooJdspexGHsq0esXzxXXer8WzvCAY%2B8iSwOkr8Vv6SRfZ329P4s%2BP1eQntM68gAM1rufBWsyp81qWRcsxCeIvOSKDPT3zezNLcs7JqyVsMSW76Io36J7QQuiA5las%2FIen3boQMFiPRxSWB5skwz6sY4idMYaXICfg5iMtE%2BErktGH8%2FfJUQgNe7D%2FY6Fzkz49dYrzuF4DHUls86ds0no54vMasDNDEKr9mTeqKwOpPuU1EYy7pmzW2FezWuEtj0A7fa032v0sNHU4reapgTTNqyfBMO5axsCQjoelc3Ze95S81kbrednLM93fv%2Fvug4UBE9lAq%2FW3xNMLP95poGOqYBFO0gpMoPDuWXAytcUnnIYQVgVc0hNjM2qyd9lXGiDK8tQZpNV28OsTDN8BebJV4ZwuKPQ09IZA2979yOFv04NCB%2B4zneRwxii6RzGvARZlMMZjAhRL%2F32jS2PF1nRpbTNcxDOAtKvtGnnNxsoizl3tAaP5P3aIZzahUlEM5b6GzfMuyLRT%2FTLxi%2Bc8xV5vA7DDpiKJvyyJL9mNZ9IKzIoZJZ%2BXQ4yQ%3D%3D&X-Amz-SignedHeaders=host&X-Amz-Signature=3b92b829eccd001441beda35b477e74cd84a3c10ff3c1a7a0080ceb58de832b3)

Lab Diagram[](https://ssh.instantterminal.acloud.guru/)

Instant Terminal

## Credentials

[How do I connect?](https://help.acloud.guru/hc/en-us/articles/360001382275-Hands-On-Labs-Getting-Started)

## AWS Account

Username

Password

[](https://205376115077.signin.aws.amazon.com/console?region=us-east-1)

Open Link in Incognito Window

[How do I connect?](https://help.acloud.guru/hc/en-us/articles/360001382275-Hands-On-Labs-Getting-Started)

## Additional Resources

#### Reference Links:

-   All files required for this hands-on lab are located in the folder named  `Building_and_Troubleshooting_a_Serverless_Web_Application`  that you will find in the following  [GitHub repository](https://github.com/ACloudGuru/hands-on-aws-troubleshooting).
-   [Vi Editor cheat sheet](https://web.mit.edu/merolish/Public/vi-ref.pdf)
-   [Using AWS Lambda with AWS X-Ray](https://docs.aws.amazon.com/lambda/latest/dg/services-xray.html)

----------

You will need this script for the  **Create an S3 Bucket and Upload the Website Files**  objective:

`{ "Version": "2012-10-17", "Id": "Policy1650555565088", "Statement": [ { "Sid": "Stmt1650555563210", "Effect": "Allow", "Principal": "*", "Action": "s3:GetObject", "Resource": "arn:aws:s3:::mywebsitefiles6754376825/*" } ] }`

## Learning Objectives

Create a DynamoDB Table

1.  Create the DynamoDB table and populate it using the file named  `items.json`. All files required for this hands-on lab are located in the folder named`Building_and_Troubleshooting_a_Serverless_Web_Application`  that you will find in the following  [GitHub repository](https://github.com/ACloudGuru/hands-on-aws-troubleshooting).

Create a Lambda Function with an API Gateway Endpoint

1.  Create a Lambda function using`lambda_function.py`.
2.  Test the function to see if it works.
3.  Diagnose and fix an error with the function configuration.
4.  Add an API gateway endpoint to your function; make sure you select a  **REST API**.
5.  Test that the API gateway can be used to invoke your Lambda function.

Create an S3 Bucket and Upload the Website Files

1.  Modify  `index.html`  to add the invoke URL of your API Gateway endpoint.
2.  Create an S3 bucket with public access enabled.
3.  Upload the following website files to your bucket. Make sure they have public-read enabled:  `index.html`,  `error.html`,  `cookie.html`
4.  Configure S3 static website hosting on your S3 bucket.
5.  Check you can access everything from the S3 website-hosting URL.

Configure X-Ray

1.  Enable tracing from within the Lambda function.
2.  Enable the API gateway endpoint to send traces.
3.  Add the Lambda Layer to your function using the file named  `layer.zip`.
4.  Update your Lambda function code to import the X-Ray SDK to your function using the snippet provided named  `lambda_function_xray.py`.
5.  Test the function to see if it works.
6.  Diagnose and fix an error with the function configuration.

Review The X-Ray Service Map

1.  Generate some traffic to your website.
2.  Review the X-Ray service map and traces.
3.  Break the application and see the results displayed in X-Ray.
