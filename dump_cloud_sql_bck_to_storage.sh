#!/bin/bash

#Configure previously your gcloud account with necessary permissions.
#Check service account asociated to Cloud SQL Instance and give Cloud Storage permissions in your bucket.

ACCESS_TOKEN=$(gcloud auth print-access-token)
BUCKET_NAME="YOUR BUCKET"
PATH_TO_DUMP_FILE=" PATH FILE NAME"
DATABASE_NAME1="DATABASE"
PROJECT_ID="PROJECT ID IN GCP"
INSTANCE_NAME="CLOUD SQL INSTANCE"

#Add DATABASE_NAME2 or more if you need more than one database


generate_data()
{
    cat <<EOF
{
    "exportContext": {
        "fileType": "SQL",
        "uri": "gs://$BUCKET_NAME/$PATH_TO_DUMP_FILE",
        "databases": ["$DATABASE_NAME1"]
    }
}
EOF
}


curl --header "Authorization: Bearer ${ACCESS_TOKEN}" \
     --header 'Content-Type: application/json' \
     --data "$(generate_data)" \
   -X POST \
   https://sqladmin.googleapis.com/v1/projects/${PROJECT_ID}/instances/${INSTANCE_NAME}/export
