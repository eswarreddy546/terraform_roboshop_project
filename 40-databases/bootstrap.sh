#!/bin/bash
component=$1
environment=$2

dnf install ansible -y

REPO_URL=https://github.com/eswarreddy546/ansible-roboshop-roles-tf.git
REPO_DIR=/opt/roboshop/ansible
ANSIBLE_DIR=ansible-roboshop-roles-tf

mkdir -p $REPO_DIR
mkdir -p /var/log/roboshop/
touch ansible.log
cd $REPO_DIR

rm -rf $ANSIBLE_DIR
git clone $REPO_URL
cd $ANSIBLE_DIR

echo "environment is: $environment"

ansible-playbook -e component=$component -e env=$environment main.yaml