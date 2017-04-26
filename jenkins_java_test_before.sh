#!/bin/sh
# 项目地址
PROJECT_PATH=/root/.jenkins/workspace
# 项目名称
PROJECT_NAME=salary
PROPERTIES_FILE=src/main/resources/application.properties
DEV=dev
echo "start check"
if [ ! -d "${PROJECT_PATH}/${PROJECT_NAME}" ];then
	echo "file not exeit" 
fi
active=`grep spring.profiles.active "${PROJECT_PATH}/${PROJECT_NAME}/${PROPERTIES_FILE}" |cut -d'=' -f2` 
echo "spring.profiles.active=${active}"
if  [ ! "${DEV}"x = "${active}"x ];then
	echo "not dev file"
fi
