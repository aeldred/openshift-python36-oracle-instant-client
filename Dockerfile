FROM centos/python-36-centos7

# Python 3.6 Centos7 image with Oracle Instant Client installed

# change Docker user to root
#USER root

# install dev tools 
RUN INSTALL_PKGS="wget libaio-devel" && \
    yum -y --setopt=tsflags=nodocs install --enablerepo=centosplus $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    # Remove centos-logos (httpd dependency) to keep image size smaller.
    rpm -e --nodeps centos-logos && \
    yum -y clean all --enablerepo='*'


# install the Oracle dependencies./tmp/oracle_fdw-ORACLE_FDW_2_0_0/oracle_fdw.control
COPY oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp/oraclelibs/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
COPY oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp/oraclelibs/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm


RUN cd /tmp/oraclelibs && \
    rpm -Uvh oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    rpm -Uvh oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm 

# change back to the regular user
ENV ORACLE_HOME /usr/lib/oracle/12.2/client64/lib

# set the oracle library path
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.2/client64/lib:${LD_LIBRARY_PATH}

USER 1001
