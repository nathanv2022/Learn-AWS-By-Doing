
# Introduction to AWS Identity and Access Management (IAM)
## Introduction

AWS Identity and Access Management (IAM) is a service that allows AWS customers to manage user access and permissions for their accounts, as well as available APIs/services within AWS. IAM can manage users and security credentials (such as API access keys), and allow users to access AWS resources. In this lab, we will walk through the foundations of IAM. We'll focus on user and group management, as well as how to assign access to specific resources using IAM-managed policies. We'll learn how to find the login URL where AWS users can log in to their account and explore this from a real-world use case perspective.

## Prerequisites

Ensure you are operating out of the  **N. Virginia**  (`us-east-1`) region.

-   `user-1`  password:  `3Kk6!AY36^5h1rolJYb@C`
-   `user-2`  password:  `3Kk6!AY36^5h1rolJYb@C`
-   `user-3`  password:  `3Kk6!AY36^5h1rolJYb@C`

## Challenge Objectives

-Add the Users to the Proper Groups

-Add the following users to their proper groups:

-   `user-1`  should be in the  `S3-Support`  group.
-   `user-2`  should be in the  `EC2-Support`  group.
-   `user-3`  should be in the  `EC2-Admin`  group.

-Use the IAM Sign-In Link to Sign In as a User

-Copy the IAM user sign-in link in the AWS console, open an incognito window, and sign in as either  `user-1`,  `user-2`, or  `user-3`  with the password provided on the lab page.
