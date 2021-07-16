mv /usr/local/bin/apache-maven-3.2.3/conf/settings.xml /usr/local/bin/apache-maven-3.2.3/conf/settings.xml.bak
/bin/cp -rf /openrasp/git/settings.xml   /usr/local/bin/apache-maven-3.2.3/conf/settings.xml

mkdir -p /openrasp/git/openrasp/openrasp-v8/build64 
cd /openrasp/git/openrasp/openrasp-v8/build64
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DENABLE_LANGUAGES=java ..
make



# 复制动态链接库到 resources 目录
mkdir -p ../java/src/main/resources/natives/linux_64 && cp ./java/libopenrasp_v8_java.so $_


# 编译 v8-1.0-SNAPSHOT.jar，安装 v8-1.0-SNAPSHOT.jar 到 maven 本地仓库
cd ../java
mvn clean install -DskipTests=true

cd /openrasp/git/openrasp/agent/java
mvn versions:use-latest-releases -Dincludes=com.baidu.openrasp:sqlparser
mvn clean package -DskipTests=true
