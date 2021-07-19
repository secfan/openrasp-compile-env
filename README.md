# OPENRASP AGENT容器编译打包操作指南

## 内容简介

openrasp agent官方文档提供的编译方法，在对V8代码进行编译时需要部署复杂的编译环境，编译过程在本地执行较为繁琐。我们通过对编译环境的容器化开发，支持了在本地通过拉取编译环境的镜像，挂载openrasp源码及调用编译脚本的方式，简易、标准化实现了编译openrasp agent的功能。

## 文件结构
- [Dockerfile:制作编译镜像文件的dockerfile](Dockerfile)
  - 需自行下载1. [jdk-7u80-linux-x64.rpm](https://www.oracle.com/java/technologies/javase/javase7-archive-downloads.html)
  - 需自行下载2. [apache-maven-3.2.3-bin.zip](https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.2.3/apache-maven-3.2.3-bin.zip)
- [settings.xml：编译镜像制作依赖文件](settings.xml)
- [docker-compose.yml：编译镜像编排、启动文件](docker-compose.yml)
- [genenginejar.sh：openrasp一键式编译脚本](genenginejar.sh)



## 操作准备
Linux服务器安装docker、docker-compose

## 操作步骤

1、克隆openrasp-compile-env至本地

```
#下载源码，进入工作目录
cd ~
git clone https://github.com/secfans/openrasp-compile-env.git
```

2、从dockerhub拉取openrasp-compile-env 1.0版本镜像

```
docker pull secfans/openrasp-compile-env:1.0
```

3、下载openrasp源码

```
cd ~/openrasp-compile-env
git clone https://github.com/baidu/openrasp -b 指定branch/tag，如：v1.3.6
```

4、下载v8源码到指定路径：~/openrasp-compile-env/openrasp

```
cd ~/openrasp-compile-env/openrasp
git clone https://github.com/baidu-security/openrasp-v8.git -b 指定branch/tag，如：v21
```

5、通过docker-compose启动本地容器化编译环境

```
cd ~/openrasp-compile-env
docker-compose up -d
```

6、调整文件权限

```
# 目录授权
chmod -R 777 ~/openrasp-compile-env
```

7、使用容器化本地编译环境执行脚本化编译（目前仅支持Linux x64版本）：

```
docker exec openrasp-compile-env sh /openrasp/git/genenginejar.sh
```

8、在git代码路径下获取所需要的jar包。

