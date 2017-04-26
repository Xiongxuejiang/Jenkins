#!/bin/sh
PROJECT_PATH=/root/.jenkins/workspace/salary_h5_test
NGINX_PATH=/usr/nginx/nginx-1.11.13/html/salary_h5

cd ${PROJECT_PATH}
cp -rf dist ${NGINX_PATH}/
