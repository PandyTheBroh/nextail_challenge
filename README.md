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
My approach is based on the AWS CLI and Bash Scripting; keeping it simple. I have used the AWS CLI version 2.
