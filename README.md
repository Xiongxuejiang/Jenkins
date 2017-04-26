# Jenkins


# 导言
 <p>
一直对持续集成和自动化部署感兴趣，现在有机会学习和使用Jenkins了，在这过程中，由于网上的资料参差不齐，所以走了不少弯路，所以我打算编写文档来记录自己在Jenkins之中走过的路。
</p>

# 1.Jenkins 安装方式
<p>
  Windows和Linux下有一种比较简便的安装方式,我们就采用这种最简单的办法去解决问题。
</p>

<p >

  在官网下载war包[http://updates.jenkins-ci.org/download/war/](http://updates.jenkins-ci.org/download/war) ，然后直接丢在tomcat的webapps,然后启动tomcat 就完成Jenkins 的安装了。这种是我感觉最方便的方式，我曾经打算书Ubuntu的apt-get 安装，但是这样太坑了,墨迹了半天我还是不知道怎么开启的所以果断放弃了。

</p>
<p>
  启动Tomcat以后访问Tomcat的地址加Jenkins{例如：[http://127.0.0.1:8080/jenkins](http://127.0.0.1:8080/jenkins)}，第一次加载可能有点慢，加载成功以后就出现以下界面就成功了。输入以下地址的密码就进入定制Jenkins了，选择左边默认的定制方式，下载完插件以后创建账号密码就可以正常使用了。
</p>

![第一次启动.png](http://upload-images.jianshu.io/upload_images/5611877-1fab951bc6f773cb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![
![
![QQ图片20170411141904.png](http://upload-images.jianshu.io/upload_images/5611877-f8f1b682d9b813ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
](http://upload-images.jianshu.io/upload_images/5611877-0680ddf4bd731a39.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
](http://upload-images.jianshu.io/upload_images/5611877-3bd342b2c084c41f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<p>
到这里Jenkins 就安装好了。
</p>

# 2.Jenkins 插件管理和配置

### 插件管理
<p>
插件管理在 系统管理 -> 管理插件 里面。
</p>


我们需要先完成的插件的安装才能配置和管理我们Job,有以下几种插件是我们需要的：
  * Git plugin(Git 源码管理插件)
  * Maven Integration plugin(maven 打包插件)
  * Publish Over SSH(远程访问的SSH插件)


### 全局工具配置

<p>
安装完这几个插件以后我们进行一些系统设置的全局工具配置，全局工具配置在 系统管理 -> Global Tool Configuration 里面。
</p>

+ JDK配置

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-34e56594b9d7aabe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


+ Git配置

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-5afd1f363be98813.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

+ Maven配置

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-a546fae5dc582498.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 系统配置

+ 邮件配置
<p>
邮件配置一定填写的是 Jenkins Location 的 	系统管理员邮件地址，这个如果不填写的是发送不了邮件的。
</p>
![图片.png](http://upload-images.jianshu.io/upload_images/5611877-910c490e884b7d52.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-7183344e5a10cadb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

+ SSH配置

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-56b2fdad329631e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<p>
如果是服务器集群的话，就再增加一个 SSH Server。
</p>


# 3.任务管理和使用

<p>
因为我们是前后端分离的，所以我们前端和后端单独部署。
</p>

### Maven 自动化打包部署
* 1.构建一个maven项目

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-4bb98ed54c2b9603.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 2.源码管理
<p>
	Repository URL是Git 源码地址，比较重要的是 Branches to build，这个是我们要拉下的代码分支。
</p>


![图片.png](http://upload-images.jianshu.io/upload_images/5611877-5a0bea7a40ddea76.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

* 3.maven build

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-effecec1fd5b7c8f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
<p>
	Goals and options 是maven要进行的操作，我这里选择的是clean、compile和war:war 操作。
</p>

```
 clean compile war:war
```

* 4.构造环境
<p>
	我们选择在build 结束以后执行文件传送。
</p>

<p>
Source files （要传送的文件） Remove prefix（删除前缀，不删除的话会新建这个目录） Remote directory（文件目标地址） Exec command （文件传送结束以后执行的命令操作）
</p>

#### Exec command
```
chmod 777 /usr/project/deploy/*.war
sh /var/shell/Jenkins-release.sh
```

#### 我编写的自动部署脚本

```
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

```

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-cbaed58b24a4b865.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


* 5.构造设置

<p>
	Recipients 是构造以后要接收邮件的地址。
</p>

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-b184a828ddb82444.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


<p>
maven 自动化打包部署到此就结束了，让我们构造一下吧！
</p>

* 6.构造测试
<p>
    点击立即构造，maven 打包成功，执行脚本无误以后，整个自动化部署就成功了。
</p>

![图片.png](http://upload-images.jianshu.io/upload_images/5611877-fa0a5e69e1d4e2f1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
