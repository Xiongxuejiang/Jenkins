#!/bin/sh
PROJECT_PATH=/usr/project/deploy
NGINX_PATH=/usr/nginx/nginx-1.11.13/html/salary_h5

cd ${PROJECT_PATH}
# ��ѹ�ļ�
tar -cf dist.tar dist/
# ������nginx Ŀ¼��
cp -rf dist ${NGINX_PATH}/