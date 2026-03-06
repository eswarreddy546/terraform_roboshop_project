#!/bin/bash

component=$1
environment=$2

dnf install git ansible -y
ansible-galaxy collection install amazon.aws

REPO_URL=https://github.com/daws-86s/ansible-roboshop-roles-tf.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible-roboshop-roles-tf

mkdir -p $REPO_DIR
mkdir -p /var/log/roboshop/

cd $REPO_DIR

# check if repo already exists
if [ -d $ANSIBLE_DIR ]; then
    cd $ANSIBLE_DIR
    git pull
else
    git clone $REPO_URL
    cd $ANSIBLE_DIR
fi

echo "Environment is: $environment"

ansible-playbook -e component=$component -e env=$environment main.yaml