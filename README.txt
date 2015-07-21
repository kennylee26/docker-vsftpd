Build
docker build -t kennylee26/vsftpd .

Test
docker run -ti -p 20-21:20-21 -p 65400-65535:65400-65535 --name vsftpd --rm kennylee26/vsftpd bash

Run
docker run -d -p 20-21:20-21 -p 65400-65535:65400-65535 --name vsftdp kennylee26/vsftpd

Run & Persistent data
docker run --name ftp-data -v /var/www busybox echo 'Read-Only Data Container.'
docker run -d --volumes-from ftp-data -p 20-21:20-21 -p 65400-65535:65400-65535 --name vsftpd kennylee26/vsftpd /run-in-data.sh

--------------

ftp账号有两种：
1、第一种是匿名用户anonymous，可以下载/var/www下的全部文件，并且在/var/www/upload目录下拥有上传权限。但已经绑定目录，且不能删除文件。
2、第二种的管理用户。默认账号密码为 ftpuser/admin。没有绑定目录，职责是负责维护/var/www目录，把upload文件分类处理或销毁。

数据卷目录 /var/www

其他：没有用虚拟用户，因为仅仅作为容器内的ftp，安全级别不用那么严谨，另外就是不想影响容器内部网络设置。
