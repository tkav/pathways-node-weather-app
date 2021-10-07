#!/bin/bash

#Get REPO URL
REPO_URL=$(aws ssm get-parameter --name ${REPO_PARAMETER_NAME} --region ${REGION} --output text --query Parameter.Value)

#Login to ECR
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_NUMBER}.dkr.ecr.${REGION}.amazonaws.com

#Tag container
docker tag node-weather-app:latest ${REPO_URL}:latest

#Push to ECR
docker push ${REPO_URL}:latest