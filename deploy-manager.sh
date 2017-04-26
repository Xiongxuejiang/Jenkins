# 项目地址
PROJECT=/usr/project
# 项目名称
PROJECT_NAME=salary
# 分支名称
BRANCH=dev-org
# tomcat 地址
TOMCAT=/usr/tomcat/apache-tomcat-8.5.8
cd $TOMCAT/bin
#run
./shutdown.sh
#删除以前的打包文件
cd $TOMCAT/webapps
rm -rf $PROJECT_NAME
# 进入项目地址
cd $PROJECT/$PROJECT_NAME
# update code
git fetch --all 
git reset --hard origin/$BRANCH
# package
echo "开始 maven clean"
echo "-----------------------------"
mvn clean
echo "开始编译"
echo "-----------------------------"
mvn compile
echo "开始打包"
echo "-----------------------------"
mvn war:war
# deploy包(不必修改)
WAR=`ls target | grep war`
# 移动war包到tomcat
cp target/$WAR $TOMCAT/webapps
cd $TOMCAT
# invoke another deploy script
sh deploy-war.sh $WAR webapps
# 开启作业控制防止Java进程退出
set -m
# 开启项目
cd $TOMCAT/bin
#run
./startup.sh
# 打印logs
cd $TOMCAT/logs
tail -f catalina.out
#windows bos 命令转换到Linux需要 set ff =unix
