
# Troubleshooting and Resolving AWS IAM Errors

## Introduction

In this hands-on lab scenario, you are a security engineer working for a new startup that's launching an online bookstore for rare and antique books. The founder, Kia, needs your help setting up her database administrators with the proper access permissions for the startup's AWS account. In order to provide access and ensure the proper security measures are in place, you will use AWS Identity & Access Management (IAM) and attach the necessary AWS-managed policy that allows full access to Amazon Relational Database Service (RDS).

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (us-east-1) region throughout the lab.

### Review Existing Policy Permissions for DBAGroup as an Administrator

1.  Log in to the AWS Management Console using  `cloud_user`  credentials.
2.  Navigate to IAM.
3.  In  _IAM Resources_  section, click  **User groups: 1**.
4.  Click  **DBAGroup**.
5.  Click the  **Permissions**  tab and click  **StudentRDSPolicy**.
6.  Click  **Cancel**  to exit.
7.  Sign out as the  `cloud_user`  by clicking your account name on the top-right navigation bar and click  **Sign Out**.

### Access a Relational Database Instance as a DBA

1.  Click  **Log back in**.
2.  Log in as  `dba-1`.  _(NOTE: The credentials are located under the  _Additional Resources section_)_
3.  Navigate to  **Amazon Relational Database Service (RDS)**.
4.  Click  **Create database**.
5.  Note the access denied message. We need to modify  `DBAGroup`  permissions as an administrator to grant DBA access.
6.  Sign out by clicking your account name on the top navigation bar and clicking  **Sign Out**.

### Modify Permissions on the DBAGroup as an Administrator

1.  Click  **Log back in**.
2.  Log in with the  `cloud_user`  credentials.
3.  Navigate to IAM.
4.  In  _IAM Resources_  section, click  **User groups: 1**.
5.  Click  **DBAGroup**.
6.  Click the  _Permissions_  tab.
7.  Click  **Add permissions**  to access the dropdown menu and click  **Attach Policies**.
8.  In  _Other permission policies_  field, search for "rds".
9.  Select  **AmazonRDSFullAccess**.
10.  Click  **Add permissions**.
11.  Log out as the  `cloud_user`  by clicking your account name on the top-right navigation bar and clicking  **Sign Out**.

### Verify Relational Database Access as a DBA

1.  Click  **Log back in**.
2.  Log back in as  `dba-1`.
3.  Navigate to  **Amazon Relational Database Service (RDS)**.
4.  Click  **Create database**.  _(NOTE: The error message is gone.)_

## Conclusion

Congratulations — you've completed this hands-on lab!
