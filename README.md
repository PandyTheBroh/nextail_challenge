# Nextail Platform Challenge 

In this repository I present the development to resolve the Nextail Platform Challenge. 

Below you can read the challenge statement:

## So we are moving a lot of files!

Let's say we have 1.000 images in a S3 bucket.

For example: http://s3.amazonaws.com/old_bucket/image123.jpg, http://s3.amazonaws.com/old_bucket/image124.jpg etc

We need to move all of this images to a new bucket called new-bucket.

For example: http://s3.amazonaws.com/new_bucket/image123.jpg, http://s3.amazonaws.com/new_bucket/image124.jpg etc

`old_bucket` and `new_bucket` are just examples, you may use any name.

### Your task

- You need to move these 1.000 images from old-bucket to new-bucket.
- As fast as possible (in this case, speed is important)
- If the process fails for any reason, it should resume (and not start from the beginning)

### We expect

- The program to be written in any programming language. 
- The program is runnable in a UNIX-like environment, if it is easy for us to test, it would be great 
- To hear your thoughts on scalability and speed if the bucket contains 10.000, 100.000, 1.000.000 of images etc. (we may talk about this in the interview)
- The code of this challenge will be written in a Git repository and zipped. Try to not write the entire program in one commit and version it as much as you can. For us, understanding your progress is valuable.
- Also, if you think this can be accomplished using any other method (not a program), we would like to hear your idea.

### Some comments

- Feel free to use files, databases or whatever you like as long as you keep it simple.
- To keep this free of charge, you may use a local S3 emulation tool or AWS free tier. 

## The Solution

My approach is based on the AWS CLI and Bash Scripting; keep it simple.

### Prerequisites

- I have used the AWS CLI version 2. To install it, just follow the official documentation provided by Amazon: 
https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html#install-bundle-other-os
- To configure the AWS CLI to use S3 correctly, just follow that official tutorial provided by Amazon:
https://aws.amazon.com/es/getting-started/hands-on/backup-to-s3-cli/

### How to use the tool

Assuming a environment correctly configured, to use the proposed solution run the next command:

`./platform_test.sh <origin_s3_bucket> <destiny_s3_bucket>`

__Example:__

`./platform_test.sh nextail-challenge-first-bucket nextail-challenge-second-bucket`

## Why this solution
I decided to solve the challenge like this, for simplicity and compatibility: 

- The solution doesn't require complex environment settings to works properly. The only requirement is the AWS CLI, which is the vendor's official tool, cross-platform, easy to install and updated frequently. On the other hand, bash scripts work fine without prior configuration on most GNU / Linux distributions.
- With the AWS CLI, operations for moving files between buckets are native and run directly on the Amazon infrastructure.
- In a first version, I used the synchronization option of the aws s3 command. This ensures that you will have an exact copy of the origin at the destination. After this, you need to delete the source files.
Later, I decided to use the mv option because it is faster due to the implicity of removing the source files in a single command.
- To ensure that the operation resumes at the same point, I use the mv option combined with checking the error code after the operation. If for some reason the file move is canceled, the error checking forces to loop and execute the operation again. Because the mv operation deletes any files copied to the destination, it will only copy the rest of the files next time.
- To avoid a possible infinity loop due to deep network issues or wrong permission settings, I have added checks against the buckets at the beginning of the loops using the `aws s3api head-bucket` command.

## Possible improvements
- This solution is developed on the condition that the repository contains only jpg files; a very simple case. If the case was more complex, we could be more precise by using the `--exclude "*" --include "* .jpg"` option of the aws s3 command.
- The aws s3 transfer commands are multithreaded. At any given time, multiple requests to Amazon S3 are in flight. For example, if you are uploading a directory via aws s3 cp localdir s3://bucket/ --recursive, the AWS CLI could be uploading the local files localdir/file1, localdir/file2, and localdir/file3 in parallel. The max_concurrent_requests specifies the maximum number of transfers that are allowed at any given time. Increasing this value - In some scenarios, you may want the S3 transfers to complete asap, using as much network bandwidth as necessary. In this scenario, the default number of concurrent requests may not be sufficient to utilize all the bandwidth available. Increasing this value may improve the time to complete an S3 transfer. __Example:__`aws configure set default.s3.max_concurrent_requests 50` __Default:__ 10
- Hadoop (the framework for the distributed processing of large data sets across clusters) has in its ecosystem the tool DistCp. It is often used to move data providing a distributed copy capability built on top of a MapReduce framework. S3DistCp is an extension to DistCp that is optimized to work with S3 and that adds several useful features. In addition to moving data between HDFS and S3, S3DistCp is very versatile for the file manipulations. In case to be necessary move a huge amount of images frequently, use S3DistCp could be a solution. I haven't developed this proposal due to the complexity to prepare the environment (install and configure hadoop, distcp and the S3DistCp extension, etc).
