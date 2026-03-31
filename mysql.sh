#!/bin/bash

source ./common.sh
app_name=mysql

check_root

echo -e "Please enter Root password to setup"
read -s MYSQL_ROOT_PASSWORD

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "Installing Mysql server"

systemctl enable mysqld &>>$LOG_FILE
systemctl start mysqld 
VALIDATE $? "Start Mysqld"

mysql_secure_installation --set-root-pass $MYSQL_ROOT_PASSWORD &>>$LOG_FILE
VALIDATE $? "setting Mysql root password"

print_time