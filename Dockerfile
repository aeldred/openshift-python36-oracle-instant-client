FROM centos/python-36-centos7

# Python 3.6 Centos7 image with Oracle Instant Client installed

ADD oracle-instantclient*.rpm /tmp/

RUN  INSTALL_PKGS="wget libaio-devel" && \
     yum -y install /tmp/oracle-instantclient*.rpm && \
     yum -y --setopt=tsflags=nodocs install --enablerepo=centosplus $INSTALL_PKGS && \
     rpm -V $INSTALL_PKGS && \
     rm -rf /var/cache/yum && \
     rm -f /tmp/oracle-instantclient*.rpm && \
     echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient12.2.conf && \
     ldconfig

# change back to the regular user
ENV ORACLE_HOME /usr/lib/oracle/12.2/client64/lib

# set the oracle library path
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.2/client64/lib:${LD_LIBRARY_PATH}
ENV PATH=$PATH:/usr/lib/oracle/12.2/client64/bin

USER 1001
