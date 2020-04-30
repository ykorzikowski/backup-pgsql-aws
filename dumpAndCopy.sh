#!/bin/bash

./dumpDatabase.sh
if [ $? -ne 1 ]; then
    aws s3 cp /pg_backup/*.dump "$S3"
    rm /pg_backup/*
    exit 0
fi

exit 1
