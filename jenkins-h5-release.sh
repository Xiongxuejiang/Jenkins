#!/bin/sh
PROJECT_PATH=/usr/project/deploy
NGINX_PATH=/usr/nginx/nginx-1.11.13/html/salary_h5

cd ${PROJECT_PATH}
# 解压文件
tar -cf dist.tar dist/
# 拷贝到nginx 目录下
cp -rf dist ${NGINX_PATH}/