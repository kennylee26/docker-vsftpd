# vsftpd-Server
#
# VERSION 0.0.1
# see also: https://github.com/panubo/Dockerfiles/tree/master/vsftpd
# NAME: kennylee26/vsftpd
# Command format: Instruction [arguments command] ..

# 第一行必须指定基于的基础镜像
FROM kennylee26/ubuntu

# 维护者信息
MAINTAINER kennylee26 <kennylee26@gmail.com>

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends vsftpd db5.3-util && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN useradd ftpuser -g ftp -d /home/ftpuser/ -s /bin/bash -m
RUN echo 'ftpuser:admin' | chpasswd
RUN chmod a-w /home/ftpuser/

RUN mkdir -p /var/www/====upload====/ && chmod -R 777 /var/www/====upload====/
RUN chown ftpuser:ftp /var/www/
RUN chown ftp:ftp /var/www/====upload====/

COPY ["conf/vsftpd.conf","/etc/vsftpd.conf"]
RUN ["mkdir","-p","/var/run/vsftpd/empty"]

VOLUME ["/var/www/"]

COPY run.sh /run.sh
COPY run-in-data.sh /run-in-data.sh 
RUN chmod +x /*.sh

# Define working directory.
WORKDIR /root

# Define default command.
EXPOSE 20-21 65400-65410

CMD ["/run.sh"]
