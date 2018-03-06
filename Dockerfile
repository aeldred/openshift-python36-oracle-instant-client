FROM python:3.6

# Python 3.6 Centos7 image with Oracle Instant Client installed

# install dev tools 
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-rpms && \
	yum-config-manager --enable rhel-7-server-eus-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \	
    yum -y groupinstall 'Development Tools' && \
    yum clean all
	
RUN yum-config-manager --enable rhel-server-rhscl-7-rpms && \
    yum-config-manager --enable rhel-7-server-rpms && \
	yum-config-manager --enable rhel-7-server-eus-rpms && \
    yum-config-manager --enable rhel-7-server-optional-rpms && \	
	INSTALL_PKGS="wget libaio-devel" && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all


# install the Oracle dependencies./tmp/oracle_fdw-ORACLE_FDW_2_0_0/oracle_fdw.control
COPY oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp/oraclelibs/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
COPY oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp/oraclelibs/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm


RUN cd /tmp/oraclelibs && \
    rpm -Uvh oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    rpm -Uvh oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm 

ENV ORACLE_HOME /usr/lib/oracle/12.2/client64/lib
