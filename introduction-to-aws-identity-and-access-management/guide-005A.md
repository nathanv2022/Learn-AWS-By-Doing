
## Introduction

AWS Identity and Access Management (IAM) is a service that allows AWS customers to manage user access and permissions for the accounts and available APIs/services within AWS. IAM can manage users, security credentials (such as API access keys), and allow users to access AWS resources.

In this lab, we discover how security policies affect IAM users and groups, and we go further by implementing our own policies while also learning what a role is, how to create a role, and how to assume a role as a different user.

By the end of this lab, you will understand IAM policies and roles, and how assuming roles can assist in restricting users to specific AWS resources.

## Objectives
### Create the Correct S3 Restricted Policies and Roles
Perform the following tasks:
1.  Create the  `S3RestrictedPolicy`  IAM policy. Ensure only the appconfig buckets are accessible.
    -   Select the S3 service and all S3 actions
    -   Select all resources except bucket
    -   Add the appconfig bucket names to the policy
2.  Create the  `S3RestrictedRole`  IAM role.
    -   Set the trusted entity to another AWS account
    -   Add your account ID
    -   For permissions, select the S3RestrictedPolicy
3.  Revoke the  `AmazonS3FullAccess`  access policy from the  `developergroup`.
4.  Attach the  `S3RestrictedPolicy`  to the  `dev1`  user.

### Configure IAM So the dev3 User Can Assume the Role
Perform the following tasks:
1.  Create the  `AssumeS3Policy`  IAM policy.
    -   Select the STS service
    -   Select AssumeRole under the write options
    -   Add the S3RestrictedRole
2.  Attach the  `AssumeS3Policy`  to the  `dev3`  user.
3.  Assume the  `S3RestrictedRole`  as the  `dev3`  user.
    -   Log in as the dev3 user
    -   Switch roles to the S3RestrictedRole
    -   Verify access in S3

## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Create the Correct S3 Restricted Policies and Roles

#### Create the  `S3RestrictedPolicy`

1.  Once you are logged in to the AWS Management Console, navigate to IAM.
2.  From the left-side menu, click  **Policies**.
3.  Click  **Create Policy**.
4.  In  _Service_, click  **Choose a service**.
5.  Type and select  **S3**.
6.  In  _Actions_, select  **All S3 actions**.
7.  Click the arrow next to  _Resources_, and select  **Any**  or  **Any in this account**  for all resources other than  _bucket_.
8.  Open a new browser tab, and navigate to S3.
9.  Under  _Buckets_, copy the bucket name containing  `appconfigprod1`.
10.  Return to IAM.
11.  In  _Resources_, under  _bucket_, click  **Add ARN**.
12.  Paste in the  _Bucket name_  you just copied, and click  **Add**.
13.  Return to S3 and repeat the process with the bucket name containing  `appconfigprod2`.
14.  In IAM, once both buckets are added, click  **Next: Tags**.
15.  Click  **Next: Review**.
16.  For  _Name_, enter "S3RestrictedPolicy", and click  **Create policy**.

#### Create the  `S3RestrictedRole`

1.  From the IAM dashboard menu, select  **Roles**.
2.  Click  **Create role**.
3.  Under  _Trusted entity type_, select  **AWS account**.
4.  Under the  _An AWS account_  section that pops up, make sure  **This account**  is selected.
5.  Copy the account number next to  _This account_. You will need this later in the lab.
6.  Click  **Next**.
7.  In the search field, enter "S3" and select  `S3RestrictedPolicy`.
8.  Click  **Next**.
9.  In  _Role name_, enter "S3RestrictedRole". You should see in the JSON block that the trusted entity is your account number. This means that anything that is in this account can assume this role.
10.  Click  **Create role**.

#### Revoke the  `S3 Administrator Access`  Policy to the  `dev1`  User

1.  AWS now auto logs out when logging in as another user (even if in a new Incognito/Private Window). As a work around, you can right-click the lab's blue "Open Link in Incognito/Private Window` button and copy the link into a different browser. You'll then be able to be logged into the other account using the lab provided credentials.
2.  Use the following credentials to log in:
    -   _Account ID_: The same account ID you previously copied
    -   _User_:  `dev1`
    -   _Password_:  `3Kk6!AY36^5h1rolJYb@C`
3.  Navigate to  **S3**  to see what this user has access to.
4.  Select one of the  `customerdata`  buckets and open it in a new tab. You should see that there are no objects, but you do have access to it.
5.  Back in S3, select one of the  `appconfig`  buckets, and open it in a new tab. You should see the same access as the  `customerdata`  bucket.
6.  Go back to the original IAM browser window that you had open.
7.  From the left-side menu, select  **User groups**.
8.  Select the  `developergroup`.
9.  Select  _Permissions_.
10.  Select the  `AmazonS3FullAccess`  policy, and click  **Remove**.
11.  Click  **Delete**.
12.  Go back to the other incognito windows for the  `dev1`  user.
13.  Refresh both windows for the  `customerdata`  and  `appconfig`  buckets. Note that you will now see an error indicating the user has insufficient permissions to list objects.

#### Attach the  `S3RestrictedPolicy`  to the  `dev1`  User

1.  Go back to the original IAM browser window.
2.  On the left-side menu, select  **Users**.
3.  Select the  `dev1`  user.
4.  Under  _Permissions_, click  **Add permissions**.
5.  Select  **Attach existing policies directly**.
6.  In the search bar, type "S3" and select  `S3RestrictedPolicy`.
7.  Click  **Next: Review**.
8.  Click  **Add permissions**.
9.  Click the arrow next to the policy, and select  **{} JSON**  to display and review the policy's contents.
10.  To verify the configuration, return to the  `dev1`  browser and attempt to access the  `appconfig`  and  `customerdata`  buckets. You should now have access to  `appconfig`  buckets, while  `customerdata`  buckets are still denied.

### Configure IAM So the  `dev3`  User Can Assume the Role

#### Create the  `AssumeS3Policy`  IAM Policy

1.  Open a new incognito browser window using the same account ID as before. Log in as the  `dev3`  user using the following credentials:
    -   _User_:  `dev3`
    -   _Password_:  `3Kk6!AY36^5h1rolJYb@C`
2.  Navigate to S3. Note that  `dev3`and verify the user's current access.
3.  Go back to the original IAM browser window.
4.  From the left-side menu, select  **Policies**.
5.  Click  **Create policy**.
6.  In  _Service_, click  **Choose a service**.
7.  Type and select  **STS**.
8.  In  _Actions_  under  _Access level_, click the arrow next to  _Write_  to expand its options, and select  **AssumeRole**.
9.  In  _Resources_  under  _role_, click  **Add ARN**.
10.  In the  _Add ARN(s)_  pop-up window, set  _Role name with path_  to "S3RestrictedRole" and click  **Add**.
11.  Click  **Next: Tags**.
12.  Click  **Next: Review**.
13.  For  _Name_, enter "AssumeS3Policy", and click  **Create policy**.

#### Attach the  `AssumeS3Policy`  to the  `dev3`  User

1.  Select the new policy.
2.  Select the  _Policy usage_  tab, and click  **Attach**.
3.  Select  `dev3`, and click  **Attach policy**.

#### Assume the  `S3RestrictedRole`  as the  `dev3`  User

1.  Go back to the other browser window where you are logged in as  `dev3`  in S3.
2.  Notice that the  `dev3`  user still doesn't have bucket access because the role has not yet been assumed.
3.  To assume the role, click the user dropdown on the top menu, and copy your account ID in your clipboard.
4.  Click  **Switch Roles**.
5.  In the new window, click  **Switch Role**.
6.  Set the following values:
    -   _Account:_  The account ID you just copied
    -   _Role:_  `S3RestrictedRole`
    -   _Display Name:_  `S3RestrictedRole`
7.  Click  **Switch Role**.
8.  To verify the role has been assumed, attempt to access the  `appconfig`  and  `customer data`  buckets. You should now have access to  `appconfig`  buckets, while  `customer data`  buckets are still denied.

## Conclusion

Congratulations — you've completed this hands-on lab!
