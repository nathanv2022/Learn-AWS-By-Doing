# Reduce Storage Costs with EFS

## Description

Amazon Elastic File System (Amazon EFS) provides a simple, serverless elastic file system that lets you share file data without provisioning or managing storage. In this lab, we modify 3 existing EC2 instances to use a shared EFS storage volume instead of duplicated Elastic Block Store volumes. This reduces costs significantly, as we only need to store data in 1 location instead of 3. By the end of this lab, you will understand how to create EFS volumes and attach them to an EC2 instance.

## Objectives

 - [ ]   1. Create EFS Filesystem
Create an EFS file system called `SharedWeb` that we will attach to our EC2 instances.
 - [ ] 2. Mount the EFS Filesystem and Test It
Create the directory `/efs`.
Attach the EFS file system to our instance, and copy our existing data to it from `/data`.
 - [ ] 3. Remove Old Data
Unmount the `/data` partition, and delete the volume in the EC2 console.
    
## Solution

Log in to the AWS Management Console using the credentials provided on the lab instructions page. Make sure you're using the  _us-east-1_  region.

### Create EFS File System

#### Create an EFS Volume

1.  Navigate to  **EC2**  >  **Instances (running)**.
2.  Click the checkbox next to  **webserver-01**.
3.  Click the  **Storage**  tab and note the 10 GiB volume attached.
4.  In a new browser tab, navigate to EFS.
5.  Click  **Create file system**, and set the following values:
    -   **Name**:  _SharedWeb_
    -   **Availability and durability**:  _One Zone_
6.  Click  **Create**.
7.  Once it's created, click  **View file system**  in the top right corner.
8.  Click the  **Network**  tab and wait for the created network to become available.
9.  Once it's created, click  **Manage**.
10.  Under  **Security groups**, remove the currently attached default security group, and open the dropdown menu to select the provided EC2 security group (_not_  the default).
11.  Click  **Save**.
12.  Return to the EC2 browser tab.
13.  Click  **Security Groups**  in the left-hand menu.
14.  Click the checkbox next to that same security group (the one that is not default).
15.  Click the  **Inbound rules**  tab.
16.  Click  **Edit inbound rules**.
17.  Click  **Add rule**, and set the following values:
    -   **Type**:  _NFS_
    -   **Source**:  _Custom_,  _0.0.0.0/0_
18.  Click  **Save rules**.
19.  Click  **EC2 Dashboard**  in the left-hand menu.
20.  Click  **Instances (running)**.
21.  With  `webserver-01`  selected, click  **Connect**  in the top right corner.
22.  Click  **Connect**. This should take you to a new terminal showing your EC2 instance in a new browser tab or window.

### Mount the EFS File System and Test It

1.  In the terminal, list your block devices:
    
    `lsblk`
    
2.  View the data inside the 10 GiB disk mounted to  `/data`:
    
    `ls /data`
    
3.  Create a mount point or directory to attach our EFS volume:
    
    `sudo mkdir /efs`
    
4.  Return to the AWS EFS console showing the  `SharedWeb`  file system.
    
5.  Click  **Attach**.
    
6.  Select  **Mount via IP**.
    
7.  Copy the command under  **Using the NFS client:**  to your clipboard.
    
8.  Return to the terminal, and paste in the command.
    
9.  Add a slash right before  `efs`  and press  **Enter**.
    
10.  View the newly mounted EFS volume:
    
    `ls /efs`
    
    Nothing will be returned, but that shows us it's mounted.
    
11.  List the block devices again:
    
    `lsblk`
    
12.  View the mounts:
    
    `mount`
    
13.  View file system mounts:
    
    `df -h`
    
14.  Move all files from  `/data`  to the  `/efs`  file system:
    
    `sudo rsync -rav /data/* /efs`
    
15.  View the files now in the  `/efs`  file system:
    
    `ls /efs`
    
    This time, a list should be returned.
    

### Remove Old Data

#### Remove Data from  `webserver-01`

1.  Unmount the partition:
    
    `sudo umount /data`
    
2.  Edit the  `/etc/fstab`  file:
    
    `sudo nano /etc/fstab`
    
3.  Remove the line starting with  `"UUID="`  by placing the cursor at the beginning of the line and pressing  **Ctrl+K**.
    
4.  In the AWS console, navigate to the EFS tab.
    
5.  In the  **Using the NFS client:**  section, copy the IP in the command.
    
6.  Back in the terminal, paste in the IP you just copied:
    
    `<NFS MOUNT IP>:/`
    
7.  Press the  **Tab**  key twice.
    
8.  Add the mount point and file system type (`nfs4`), so that the line now looks like this (with a tab after  `/data`):
    
    `<NFS MOUNT IP>:/ /data nfs4`
    
9.  Back on the EFS page of the AWS EFS console, copy the options (the part of the command starting with  `nfsvers`  and ending with  `noresvport`).
    
10.  In the terminal, press  **Tab**  after  `nfs4`  and add the copied options to the line with two zeroes at the end, so that it now looks like this:
    
    `<NFS MOUNT IP>:/ /data nfs4 <OPTIONS> 0 0`
    
11.  Save and exit by pressing  **Ctrl+X**, followed by  `Y`  and  **Enter**.
    
12.  Unmount the  `/efs`  to test if this worked:
    
    `sudo umount /efs`
    
13.  View the file systems:
    
    `df -h`
    
14.  Try and mount everything that is not already mounted:
    
    `sudo mount -a`
    
15.  View the file systems again and check if  `10.0.0.180:/`  is mounted:
    
    `df -h`
    
    You should see the NFS share is now mounted on  `/data`.
    
16.  View the contents of  `/data`:
    
    `ls /data`
    
17.  Navigate back to the AWS console with the  **Connect to instance**  EC2 page open.
    
18.  Click  **EC2**  in the top left corner.
    
19.  Click  **Volumes**.
    
20.  Scroll to the right and expand the  **Attached Instances**  column to find out which 10 GiB volume is attached to  `webserver-01`.
    
21.  Click the checkbox next to the 10 GiB volume attached to  `webserver-01`.
    
22.  Click  **Actions**  >  **Detach volume**.
    
23.  Click  **Detach**.
    
24.  Once it's detached, click the checkbox next to the same volume again.
    
25.  Click  **Actions**  >  **Delete volume**.
    
26.  Click  **Delete**.
    

#### Remove Data from  `webserver-02`  and  `webserver-03`

1.  Click  **Instances**  in the left-hand menu.
    
2.  Click the checkbox next to  **webserver-02**.
    
3.  Click  **Connect**.
    
4.  Click  **Connect**. This should launch a terminal in a new browser window or tab.
    
5.  In the tab with the terminal for  `webserver-01`, view the contents of  `/etc/fstab`:
    
    `cat /etc/fstab`
    
6.  Copy the second line (starting with an IP) to your clipboard.
    
7.  Return to the terminal you launched for  `webserver-02`.
    
8.  Unmount the  `/data`  partition:
    
    `sudo umount /data`
    
9.  Edit the  `/etc/fstab`  file:
    
    `sudo nano /etc/fstab`
    
10.  Delete the second line using  **Ctrl+K**.
    
11.  Paste in the line from your clipboard.
    
12.  Align the pasted line with the line above as seen in  `webserver-01`.
    
13.  Save and exit by pressing  **Ctrl+X**, followed by  `Y`  and  **Enter**.
    
14.  Mount it:
    
    `sudo mount -a`
    
15.  Check the disk status:
    
    `df -h`
    
16.  Check the contents of  `/data`:
    
    `ls /data`
    
17.  Return to the window with the  **Connect to instance**  EC2 page open.
    
18.  Click  **Instances**  in the top left.
    
19.  Click the checkbox next to  **webserver-03**.
    
20.  Click  **Connect**.
    
21.  Click  **Connect**. This should launch a terminal in a new browser window or tab.
    
22.  Unmount the  `/data`  partition:
    
    `sudo umount /data`
    
23.  Edit the  `/etc/fstab`  file:
    
    `sudo nano /etc/fstab`
    
24.  Delete the second line using  **Ctrl+K**.
    
25.  Paste in the line from your clipboard.
    
26.  Align the pasted line with the line above as seen in  `webserver-01`.
    
27.  Save and exit by pressing  **Ctrl+X**, followed by  `Y`  and  **Enter**.
    
28.  Mount everything that is not already mounted:
    
    `sudo mount -a`
    
29.  Check the disk status:
    
    `df -h`
    
30.  Check the contents of  `/data`:
    
    `ls /data`
    
31.  Return to the window with the  **Connect to instance**  EC2 page open.
    
32.  Navigate to  **EC2**  >  **Volumes**.
    
33.  Check the boxes for both of the 10 GiB volumes.
    
34.  Click  **Actions**  >  **Detach volume**.
    
35.  Type  _detach_  into the box, and then click  **Detach**.
    
36.  Once they're detached, select them again and click  **Actions**  >  **Delete volume**.
    
37.  Type  _delete_  into the box, and then click  **Delete**.
    

## Conclusion

Congratulations — you've completed this hands-on lab!
