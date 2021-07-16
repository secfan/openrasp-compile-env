FROM centos:7.9.2009
LABEL maintainer="cpit@chinpoast.com.cn"
RUN mkdir /usr/local/mvn \
	&& mkdir /usr/local/java
ADD apache-maven-3.2.3-bin.zip /usr/local/mvn/
ADD jdk-7u80-linux-x64.rpm /usr/local/java/
RUN echo 'nameserver 8.8.8.8' > /etc/resolv.conf \	
	&& yum install -y sudo \
	&& yum install -y git \
    && yum install -y unzip \
	&& cd /usr/local/mvn/ \
    && unzip apache-maven-3.2.3-bin.zip \
	&& cp -r apache-maven-3.2.3 /usr/local/bin \
    && export PATH=apache-maven-3.2.3/bin:$PATH \
    && export PATH=/usr/local/bin/apache-maven-3.2.3/bin:$PATH \
    && ln -s /usr/local/bin/apache-maven-3.2.3/bin/mvn /usr/local/bin/mvn \
    && echo $PATH \
	&& yum -y install gcc kernel-devel \
	&& yum -y install gcc \
	&& yum -y install gcc-c++ libstdc++-devel \
	&& yum -y install gcc-c++ \
	&& yum -y install wget \
    && yum install -y centos-release-scl \
	&& yum install -y vim-common \
	&& wget https://copr.fedoraproject.org/coprs/hhorak/devtoolset-4-rebuild-bootstrap/repo/epel-7/hhorak-devtoolset-4-rebuild-bootstrap-epel-7.repo -O /etc/yum.repos.d/devtools-4.repo \
    && yum install -y devtoolset-4-gcc devtoolset-4-binutils devtoolset-4-gcc-c++ \
	&& yum -y install make \
    && scl enable devtoolset-4 bash \
    && curl -L https://github.com/Kitware/CMake/releases/download/v3.15.3/cmake-3.15.3-Linux-x86_64.tar.gz | tar zx -C /tmp 
ENV PATH /tmp/cmake-3.15.3-Linux-x86_64/bin:$PATH
RUN cd /usr/local/java/ \
    && yum install -y glibc.i686 \
    && chmod +x jdk-7u80-linux-x64.rpm \
    && rpm -ivh jdk-7u80-linux-x64.rpm \
    && ln -s /usr/java/jdk1.7.0_80 /usr/local/java/jdk
    #设置环境变量 
ENV JAVA_HOME /usr/local/java/jdk
ENV JRE_HOME ${JAVA_HOME}/jre
ENV CLASSPATH .:${JAVA_HOME}/lib:${JRE_HOME}/lib
ENV PATH ${JAVA_HOME}/bin:$PATH

