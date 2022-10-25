
# Working with AWS SQS FIFO Queues

## Introduction

In this hands-on lab, you will learn how to create and interact with first-in-first-out (FIFO) SQS queues. This lab will provide an important distinction from SQS standard queues, noting the key characteristics and functionality differences between the two. By the end of the lab, you should feel comfortable creating and interacting with SQS FIFO queues. You will also learn and become familiar with various API actions used to interact with the SQS service via the AWS CLI and AWS SDKs.

## Solution

Open three terminal windows and log in to the provided public instance on the lab page via SSH:

`ssh cloud_user@<PUBLIC_IP_ADDRESS>`

We'll be using each of them at the same time, so you'll want to make sure you know which is which. It could help to change the background color on each window so you can easily tell them apart.

### Create a FIFO SQS Queue (_First Terminal_)

1.  In the first terminal window, create a queue:
    
    `python3.5 create_queue.py`
    
2.  When the command finishes, we'll see the URL of our queue (e.g.,  _[https://queue.amazonaws.com/xxxxxxxxxxxx/mynewq](https://queue.amazonaws.com/xxxxxxxxxxxx/mynewq)_). Copy that URL.
    
3.  Open the  `sqs_url.py`  file:
    
    `vim sqs_url.py`
    
4.  Update the file so it includes the URL you just copied:
    
    `QUEUE_URL = 'https://queue.amazonaws.com/xxxxxxxxxxxx/mynewq'`
    
    Save and quit the file by hitting  **Escape**  and entering  `wq!`.
    
5.  View the contents of the file to make sure it's updated:
    
    `cat sqs_url.py`
    

### Monitor the Queue (_Second Terminal_)

1.  In the second terminal window, run a script that will keep track of what's going on in our queue:
    
    `python3.5 queue_status.py`
    
    That will check on messages in our queue, so leave it running in that window. You may want to make this window smaller than the others to keep it out of the way while still keeping an eye on it.
    

### Add Messages to Queue (_Third Terminal_)

1.  In the third terminal window, run a script to start adding messages to the queue:
    
    `python3.5 fifo_producer.py`
    
    We'll see information start to appear. After a few seconds, we'll also see the second/monitoring terminal window change, with the numbers starting to increase for the different kinds of messages.
    
    It will take a couple minutes to finish, and we will see 50 messages total in the monitoring terminal window.
    

### Receive Messages and Extract Metadata (_First Terminal_)

1.  Once the producer is done running, in the first terminal, run a script that will receive messages, extract data from them, and then delete them:
    
    `python3.5 fifo_consumer.py`
    
    In the monitoring terminal window, we'll see the number of messages start to decrease.
    
2.  Hit  **Ctrl**+**C**  to cancel out of the consumer process.
    
3.  Open the  `fifo_consumer`  script:
    
    `vim fifo_consumer.py`
    
4.  Hit  **a**  so we can start editing.
    
5.  Above the  `sqs.delete_message`  method, delete the  `#`  before  `time.sleep(5)`.
    
6.  Save and exit by hitting  **Escape**  and then entering  `wq!`.
    
7.  Try to run it again:
    
    `python3.5 fifo_consumer.py`
    
    It might take a few seconds to start running now that we added the five-second wait time. Once that finishes, we're going to get an error.
    
8.  Reopen the file:
    
    `vim fifo_consumer.py`
    
9.  Change the  `VisibilityTimeout`  from  `5`  to  `10`.
    
10.  Save and exit by hitting  **Escape**  and then entering  `wq!`.
    
11.  Remove all the messages from the queue:
    
    `python3.5 purge_queue.py`
    

### Run Everything at Once

1.  In the first terminal window, run:
    
    `python3.5 fifo_consumer.py`
    
    There isn't anything for it to process, so it will wait for up to 10 seconds, and then it's going to time out, so we'll get an error.
    
2.  Now, type the same command into the window, but  _DO NOT_  hit  **Enter**  yet.
    
    `python3.5 fifo_consumer.py`
    
3.  In the second terminal window, type the following, but  _DO NOT_  hit  **Enter**:
    
    `python3.5 fifo_producer.py`
    
4.  Back in the consumer terminal, hit  **Enter**, and then  _immediately_  hit  **Enter**  in the producer terminal.
    
5.  The producer will start adding information to the queue, but it delays the messages for up to five seconds. Once messages are added, we'll see the FIFO consumer starts consuming the messages. So we can simultaneously add messages to the SQS queue, consume them from the queue, and process them to do whatever we'd like.
    

## Conclusion

Congratulations on successfully completing this hands-on lab!
