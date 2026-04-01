#!/bin/bash

source ./common.sh
app_name=rabbitmq

check_root

echo "Please enter root password to setup"
read -s MYSQL_ROOT_PASSWORD


cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOG_FILE
VALIDATE $? "Adding repo to rabbitmq"

dnf install rabbitmq-server -y &>>$LOG_FILE
VALIDATE $? "Installing rabbitmq server"

systemctl enable rabbitmq-server &>>$LOG_FILE
systemctl start rabbitmq-server &>>$LOG_FILE
VALIDATE $? "Starting rabbitmq server"

rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE

print_time

