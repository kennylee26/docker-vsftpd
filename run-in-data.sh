#!/bin/bash

mkdir -p '/var/www/====upload====/' && chmod -R 777 '/var/www/====upload====/'
chown ftpuser:ftp /var/www/
chown ftp:ftp '/var/www/====upload====/'

/usr/sbin/vsftpd
