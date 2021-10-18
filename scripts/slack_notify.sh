#!/bin/bash
message=("$@") 
curl -X POST -H 'Content-type: application/json' --data '{"text":"'"$message"'"}' $SLACK_WEBHOOK
