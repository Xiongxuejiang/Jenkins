# tagname
TAG_V=v1.0.1
# 项目地址
PROJECT_PATH=/usr/project
# 项目名称
PROJECT_NAME=salary
# tomcat 地址
TOMCAT_HOME=/usr/tomcat/apache-tomcat-8.5.12
# 判断项目路径是否存在
# 判断项目是否存在
if [ ! -d "$PROJECT_PATH" ]; then
	echo 'start mkdir project path'
	echo '-----------------------------'
	# new project path
	mkdir $PROJECT_PATH
fi
cd $PROJECT_PATH
# 判断项目是否存在
if [ ! -d "$PROJECT_PATH/$PROJECT_NAME" ]; then
	echo 'start first clone project'
	echo '-----------------------------'
	# git clone
	git clone git@118.178.89.40:salary.git
fi
# $TOMCAT_HOME
if [ ! -d "$TOMCAT_HOME" ]; then
	echo 'TOMCAT_HOME is not a really path!'
	exit 1
fi
echo 'goto project path'
# 进入项目地址
cd $PROJECT_PATH/$PROJECT_NAME
echo 'checkout tagname -'
echo $TAG_V
echo '-----------------------------'
# git checkout tagname
git checkout  $TAG_V
# package
echo 'start maven clean'
echo '-----------------------------'
mvn clean
echo 'start maven compile'
echo '-----------------------------'
mvn compile
echo 'start package war'
echo '-----------------------------'
mvn war:war
# deploy包(不必修改)
WAR=`ls target | grep war`
# 移动war包到tomcat
cp target/$WAR $TOMCAT_HOME/webapps
cd $TOMCAT_HOME
# invoke another deploy script
sh deploy-war.sh $WAR webapps
# 开启作业控制防止Java进程退出
set -m
# 开启项目
cd $TOMCAT_HOME/bin
echo 'start tomcat server '
echo '-----------------------------'
# run
./shutdown.sh
./startup.sh
# 打印logs
cd $TOMCAT_HOME/logs
tail -f catalina.out
# windows bos 命令转换到Linux需要 set ff =unix
