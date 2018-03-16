FROM openshift/base-centos7
LABEL maintainer="Jordan Guedj guedj.jordan@gmail.com"

RUN yum update -y && \
    yum groupinstall -y "Development tools" && \
    yum install -y asciidoc && \
    yum install -y git && \
    yum clean all

RUN git clone https://github.com/tinyproxy/tinyproxy.git

WORKDIR tinyproxy

RUN ./autogen.sh && \
    make && \
    make install && \
    make clean

COPY tinyproxy.conf .

ENTRYPOINT ["tinyproxy"]
CMD ["-d", "-c", "tinyproxy.conf"]

