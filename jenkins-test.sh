export BUILD_ID=jenkins-test
echo 'after test'
# 项目地址
PROJECT_PATH=/root/.jenkins/workspace
# 项目名称
PROJECT_NAME=salary_test
# tomcat 地址
TOMCAT_HOME=/usr/tomcat/apache-tomcat-8.5.8

if [ ! -d "${PROJECT_PATH}" ]; then
	echo 'PROJECT_PATH is not  real  project path'
	echo '-----------------------------'
	# exit
	exit 1
fi
# 判断项目是否存在
if [ ! -d "${PROJECT_PATH}/${PROJECT_NAME}" ]; then
	echo 'PROJECT_NAME is not existence'
	echo '-----------------------------'
	# exit
	exit 1
fi
# $TOMCAT_HOME
if [ ! -d "${TOMCAT_HOME}" ]; then
	echo 'TOMCAT_HOME is not a really path!'
    echo '-----------------------------'
    # exit
	exit 1
fi
cd ${TOMCAT_HOME}/bin
#run
./shutdown.sh
sleep 10
#删除以前的打包文件
cd ${TOMCAT_HOME}/webapps
rm -rf ${PROJECT_NAME}
# 项目
cd ${PROJECT_PATH}/${PROJECT_NAME}
WAR=`ls target | grep war`
cp -r target/${WAR} ${TOMCAT_HOME}/webapps
# 开启项目
cd ${TOMCAT_HOME}/bin
# 开启作业控制防止Java进程退出
#run
./startup.sh

