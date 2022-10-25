
# AWS DynamoDB in the Console - Creating Tables, Items, and Indexes

## Introduction

Welcome to this live AWS environment for learning the fundamentals of using DynamoDB in the AWS console. This lab provides you with essential exposure to database concepts such as partition and sort keys, how to add, delete, and update items, as well as attributes inside of a DynamoDB table. You will also add local and global secondary indexes, and use the local secondary index to query for items in your table.

## Solution

Log in to the live AWS environment using the credentials provided. Make sure you're in the N. Virginia (`us-east-1`) region throughout the lab.

### Create a DynamoDB Table

1.  Navigate to the  **DynamoDB**  console.
2.  Click  **Tables**  in the left-hand column of the DynamoDB console.
3.  Click  **Create table**, and set the following values in the  **Table details**  section:
    -   **Table name**: Enter  _MusicNotes_.
    -   **Partition key**: Enter  _Artist_, and select  **String**.
    -   _Sort Key_: Enter  _SongTitle_, and select  **String**.
4.  In the  **Settings**  section, select  **Customize settings**.
5.  In the  **Read/Write capacity settings**  section, set the following values:
    -   **Capacity mode**:  **Provisioned**
    -   **Read Capacity Auto Scaling**:  **Off**
    -   **Read Provisioned capacity units**:  _1_*
    -   **Write Capacity Auto Scaling**:  **Off**
    -   **Write Provisioned capacity units**:  _1_
6.  Click on  **Create local index**  in the  **Secondary indexes**  section.
7.  In the  **New local secondary index**  dialog, set the following values:
    -   **Sort key**:  _Rating_,  **Number**
    -   **Index name**:  _Artist-Rating-index_
    -   **Attribute projections**:  **All**
8.  Click  **Create index**.
9.  Click  **Create table**  and give it a few minutes for table creation to complete.

### Creating Items

1.  Click on  **Explore items**  in the left-hand column of the DynamoDB console.
2.  Select the  **MusicNotes**  table.
3.  Click on  **Create item**.
4.  Set the following values:
    -   **Artist**:  _Fernando_
    -   **SongTitle**:  _Sings_
5.  Click  **Add new attribute**  >  **Number**.
6.  In the new string after  **SongTitle**, set  **Rating**  to  _6_.
7.  Click  **Create item**.
8.  Select the checkbox next to the item we just created.
9.  Select  **Actions**  >  **Edit item**.
10.  Click on  **Add new attribute**  under the  **Rating**  attribute and select  **String**  from the drop down menu.
11.  In the new attribute line after  _Rating_  set the following values:
    -   **Attribute name**:  _Genre_
    -   **Value**:  _Rap_
12.  Click  **Save changes**.
13.  Create another new item of your own so we can search for it later with the Genre set to  **Rock**. Be sure to append a new string and provide both the  _Rating_  and the  _Genre_.

### Creating a Global Secondary Index

1.  Click  **Tables**  in the left-hand column of the DynamoDB console.
2.  Select the  **MusicNotes**  table and click on the  **Indexes**  tab.
3.  Click  **Create index**  in the  **Global secondary indexes**  section.
4.  In the  **Create global secondary index**  dialog, set the following values:
    -   **Partition key**:  _Genre_,  **String**
    -   **Sort key**:  _Rating_,  **Number**
    -   **Index name**:  _Genre-Rating-index_
5.  Click  **Create index**.
6.  It can take several minutes for the index to be created. Once the index is created, the  **Status**  will change to  **Active**, although we may have to reload the page to see the status change.

## Query a DynamoDB Table

1.  Click on  **Explore items**  in the left-hand column of the DynamoDB console.
2.  Select the  **MusicNotes**  table.
3.  Click on the  **MusicNotes**  table name at the top of the page and the Scan and Query section should expand out.
4.  Select  **Query**.
5.  Make sure the  **Table or index**  value is set to  **MusicNotes**.
6.  For the  **Partition key**, enter  _Fernando_.
7.  For the  **Sort key**, set the following:
    -   **Begins with**:  _Sings_
8.  Click  **Run**.
    -   Only songs by the artist  **Fernando**  and song titles beginning with  **Sings**  will be shown in the results.
9.  Change the  **Table or index**  value to  **Artist-Rating-index**.
10.  For the  **Partition key**, enter  _Fernando_.
11.  For the  **Sort key**, set the following:
    -   **Equal to**:  _6_
12.  Click  **Run**.
    -   Only songs by artist  **Fernando**  with a rating of 6 will be shown in the results list.
13.  Change the  **Table or index**  value to  **Genre-Rating-index**.
14.  For the  **Partition key**, enter  _Rock_.
15.  For the  **Sort key**, set**Between**  to  **1**  and  **10**.
16.  Click  **Run**. Only songs with the genre  _Rock_  will be shown in the results list.

## Conclusion

Congratulations on successfully completing this hands-on lab!
