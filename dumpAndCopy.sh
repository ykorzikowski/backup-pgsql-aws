#!/bin/bash
set -eux

./dumpDatabase.sh
if [ $? -ne 1 ]; then
    aws s3 --endpoint-url $ENDPOINT_URL cp /pg_backup/*.dump "$S3" || rm /pg_backup/*
    rm /pg_backup/*
    exit 0
fi

exit 1
