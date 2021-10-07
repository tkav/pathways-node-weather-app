#!/bin/bash
shopt -s expand_aliases
alias gh=~/homebrew/bin/gh

function update_aws_keys_in_github() {
  env=${1:-"approval"}

  if [ -z $AWS_ACCESS_KEY_ID ] || [ -z $AWS_SECRET_ACCESS_KEY ] || [ -z $AWS_SESSION_TOKEN ]
  then
    echo "One or more AWS Environment Variables are not set."
    return
  else
    gh secret set AWS_ACCESS_KEY_ID -b"${AWS_ACCESS_KEY_ID}"
    gh secret set AWS_SECRET_ACCESS_KEY -b"${AWS_SECRET_ACCESS_KEY}"
    gh secret set AWS_SESSION_TOKEN -b"${AWS_SESSION_TOKEN}"
  fi
}

update_aws_keys_in_github