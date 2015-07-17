#!/bin/sh

export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
export AWS_DEFAULT_REGION="ap-northeast-1"

MYSECURITYGROUP=${SWS_SECURITY_GROUP_ID}
MYIP=`curl -s ifconfig.me`

aws ec2 authorize-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32
bundle exec cap production deploy
aws ec2 revoke-security-group-ingress --group-id $MYSECURITYGROUP --protocol tcp --port 22 --cidr $MYIP/32