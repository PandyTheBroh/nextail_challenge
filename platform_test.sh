#!/bin/bash

ORIGIN_BUCKET=$1
DESTINY_BUCKET=$2
MOVE_ERROR_CHECK=1
BUCKETS_ERROR_CHECK=0

while [[ $MOVE_ERROR_CHECK != 0 ]]
do
	aws s3api head-bucket --bucket $ORIGIN_BUCKET
	BUCKETS_ERROR_CHECK=$?
	aws s3api head-bucket --bucket $DESTINY_BUCKET
	BUCKETS_ERROR_CHECK=$( expr $BUCKETS_ERROR_CHECK + $? )

	if [[ $BUCKETS_ERROR_CHECK != 0 ]]; then
		break
	fi

	aws s3 mv s3://$ORIGIN_BUCKET s3://$DESTINY_BUCKET --recursive
	MOVE_ERROR_CHECK=$?
done

