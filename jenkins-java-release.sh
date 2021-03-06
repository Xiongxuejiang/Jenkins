#!/bin/sh
export BUILD_ID=jenkins-release
echo 'after test'
# 项目地址
PROJECT_PATH=/usr/project/deploy
# 项目名称
PROJECT_NAME=salary
# tomcat 地址
TOMCAT_HOME=/usr/tomcat/apache-tomcat-8.5.8
# 备份地址
BACK_UP_PATH=/usr/backup
if [ ! -d "${BACK_UP_PATH}" ]; then
        echo 'BACK_UP_PATH is not  real  path '
        echo '-----------------------------'
        # mkdir
        mkdir ${BACK_UP_PATH}
fi
if [ ! -d "${PROJECT_PATH}" ]; then
        echo 'PROJECT_PATH is not  real  project path'
        echo '-----------------------------'
        # exit
        exit 1
fi
cd $PROJECT_PATH
# $TOMCAT_HOME
if [ ! -d "${TOMCAT_HOME}" ]; then
        echo 'TOMCAT_HOME is not a really path!'
  echo '-----------------------------'
    # exit
        exit 1
fi
# 新建备份路径
BACK_UP_DATE="$(date +%Y%m%d%H%m%S)"
echo ${BACK_UP_DATE}
cd ${BACK_UP_PATH}
mkdir ${BACK_UP_DATE}
cd ${TOMCAT_HOME}/bin
#run
./shutdown.sh
sleep 10
cd ${TOMCAT_HOME}/webapps
# 备份
OLD_WAR=`ls  ${TOMCAT_HOME}/webapps | grep war`
cp ${OLD_WAR}  ${BACK_UP_PATH}/${BACK_UP_DATE}
# 删除以前的打包文件
rm -rf ${PROJECT_NAME}
# 项目
cd ${PROJECT_PATH}
WAR=`ls ${PROJECT_PATH} | grep war`
if [ ! -d "${WARE}"]; then
        echo 'this are not have war here '
        exit 1
fi
cp ${WAR} ${TOMCAT_HOME}/webapps
# 开启项目
cd ${TOMCAT_HOME}/bin
#run
./startup.sh
