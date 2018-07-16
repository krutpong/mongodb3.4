FROM ubuntu:16.04
MAINTAINER krutpong "krutpong@gmail.com"

#add Thailand repo
RUN echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial main restricted" > /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-updates main restricted" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial universe" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-updates universe" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-updates multiverse" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-security main restricted" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-security universe" >> /etc/apt/sources.list && \
    echo "deb http://th.archive.ubuntu.com/ubuntu/ xenial-security multiverse" >> /etc/apt/sources.list && \
    apt-get update

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update
RUN apt-get -y install mongodb-org
ADD mongodb.conf /etc/mongodb.conf
RUN systemctl enable mongod


# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

EXPOSE 27017
EXPOSE 27018
EXPOSE 27019

CMD ["mongod", "--config", "/etc/mongodb.conf", "--smallfiles"]
