
# Resizing Root AWS EBS Volumes to Increase Performance

## Introduction

There are several reasons a systems administrator might need to resize a root volume. Needing larger storage capacity is the most obvious, but resizing is also necessary for increasing the base IOPS of a volume.

In this lab, we're going to learn how to resize EBS root volumes on EC2 instances.

Specifically, we're going to get hands-on experience resizing volumes in:

-   Standalone instances (a bastion host)
-   Auto scaling groups (two web server instances)

## Solution

Log in to the AWS console using the credentials provided on the lab instructions page. Make sure you are using the  `us-east-1`  region throughout the lab.

### Create an EBS Snapshot

1.  Navigate to the  _EC2_  service and select the  **Instances (running)**  link at the top of the page.
2.  Select  **bastion-host**  from the list.
3.  On the  _Description_  tab at the bottom of the page, select the  **Root device**  link, then select the  **EBS ID**  link. The root volume displays. This is the root volume you should look for.
4.  Use the  _Actions_  dropdown to select  **Create Snapshot**.
5.  For  _Description_, type  `BastionSnap`.
6.  Click  **Create Snapshot**.
7.  Close out of the success message.

### Create a New (Larger) EBS Volume

1.  When the status of our snapshot changes from  _pending_  to  _completed_, use the  _Actions_  dropdown to select  **Create Volume**.
2.  Leave the  _Volume Type_  set to  **General Purpose SSD (GP2)**.
3.  For the  _Size (GiB)_, enter  `40`. The  _IOPS_  should now be  **120/3000**.
4.  Make sure the  _Availability Zone*_  is set to  **us-east-1a**.
5.  Click  **Create Volume**  and close out of the success message.
6.  Select  **Volumes**  in the left sidebar and verify the  _40 GiB_  volume is at the top of the list and is  _available_.

### Attach the Larger EBS Volume to an EC2 Instance

The next step is to replace the existing root EBS volume that is attached to an EC2 instance with the new, larger EBS volume that we just created.

1.  Click  **Instances**  in the left sidebar.
2.  Select the  **bastion-host**  instance.
3.  Use the  _Actions_  dropdown to select  **Instance State**, then click  **Stop**.
4.  In the  _Stop Instances_  pop-up window, click  **Yes, Stop**.
5.  After the bastion host is  _stopped_, click  **Volumes**  in the left sidebar.
6.  Select the  _8-GiB_  volume associated with the bastion host.
7.  Use the  _Actions_  dropdown to select  **Detach Volume**.
8.  Click  **Yes, Detach**, then click the refresh icon at the top right of the screen. The  _8 GiB_  volume should now be  _available_.
9.  Deselect the  _8-GiB_  volume, and select the  _40-GiB_  volume.
10.  Use the  _Actions_  dropdown to select  **Attach Volume**.
11.  For  _Instance_, select the stopped  **bastion-host**  option from the dropdown. For  _Device_, enter  `/dev/xvda`.
12.  Click  **Attach**.
13.  Click  **Instances**  in the left sidebar.
14.  Check the  **bastion-host**  checkbox to select the instance.
15.  Use the  _Instance State_  dropdown to select  **Start instance**.
16.  In the Details tab, locate the public IP address and copy it to your clipboard.
17.  Open your terminal application in a new browser tab and run the following command:
    
    `$ ssh cloud_user@<PUBLIC_IP_ADDRESS>`
    
18.  Type  `yes`  at the prompt, then enter the password from the lab instructions page.
19.  List the block devices. You should see the 40G volume.
    
    `lsblk`
    
20.  Close the connection to the instance and go back to the AWS console in your browser.
    
    `exit`
    

### Create a New Auto-Scaling Launch Configuration and Update the Existing Auto-Scaling Group

The next step is to create a new auto-scaling launch configuration that uses the new (larger) EBS volume for created instances. Then, we'll update the existing auto-scaling group to use the new launch configuration.

1.  Click  **Launch Configurations**  in the left sidebar, then select the configuration.
2.  In the  _Details_  tab at the bottom of the page, click  **View User data**. Copy this text to your clipboard.
3.  Click  **Create launch configuration**.
4.  For  _Name_, enter  `newLC`.
5.  Select  **Amazon Linux AMI 2**. (You can search for the AMI ami-090fa75af13c156b4).
6.  Leave  _t2.micro_  selected, and click  **Next: Configure details**.
7.  For  _Name_, type  `newLC`.
8.  Click the arrow next to  **Advanced Details**, and paste the text we just copied into the  _User data_  field.
9.  Change  _IP Address Type_  to  **Do not assign a public IP address to any instances.**
10.  Click  **Next: Add storage**.
11.  Change  _Size (GiB)_  to  `40`.
12.  Click  **Next: Configure Security Group**.
13.  For  _Assign a security group_, choose  **Select an existing security group**.
14.  Select the  _WebServerSecurityGroup_  from the list.
15.  Click  **Review**  and  **Create launch configuration**.
16.  Choose  **Proceed without a key pair**, and check the box next to the acknowledgement.
17.  Click  **Create launch configuration**, then  **Close**.
18.  Click  **Auto Scaling Groups**  in the left sidebar.
19.  Click  **Edit**  on the right side of the  _Details_  tab.
20.  Change the  _Launch Configuration_  to  **newLC**.
21.  Click  **Save**.
22.  Click  **Instances**  in the left sidebar.
23.  Select one of the  _webserver-instance_  instances in the list (either  **us-east-1a**  or  **us-east-1b**).
24.  Use the  **Actions**  dropdown to select  **Instance State**, then click  **Terminate**. Click  **Yes, Terminate**  in the  _Terminate Instance_  window.
25.  After the new instance that Auto Scaling has created is in the  _running_  state, select it.
26.  In the  _Description_  tab, click the Root device (**/dev/xvda**) and then click the EBS ID link.
27.  (Optional) Repeat these steps with the other  **webserver-instance**  in the  _Instances_  list.

## Conclusion

Congratulations, you've successfully completed this lab!
