#!/bin/bash

ORIGIN_BUCKET=$1
DESTINY_BUCKET=$2

ERROR_CHECK=1
while [ $ERROR_CHECK != 0 ]
do
	aws s3 mv s3://$1 s3://$2 --recursive
	ERROR_CHECK=$(echo $?)
done

