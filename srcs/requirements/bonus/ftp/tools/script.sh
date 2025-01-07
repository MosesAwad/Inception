mkdir -p /var/run/vsftpd/empty

adduser $FTP_USER --disabled-password
echo "$FTP_USER:$(cat $FTP_PWD)" | /usr/sbin/chpasswd
echo "$FTP_USER" | tee -a /etc/vsftpd.userlist

mkdir /home/$FTP_USER/ftp

chown nobody:nogroup /home/$FTP_USER/ftp
chmod a-w /home/$FTP_USER/ftp

mkdir /home/$FTP_USER/ftp/files
chown $FTP_USER:$FTP_USER /home/$FTP_USER/ftp/files

echo ${FTP_USER} | tee -a /etc/vsftpd.userlist

echo "user_sub_token=$FTP_USER" >> /etc/vsftpd.conf
echo "local_root=/home/$FTP_USER/ftp" >> /etc/vsftpd.conf

# Update vsftpd.conf with the correct passive address to allow for write operations from external ftp-client programs
CONTAINER_IP=$(hostname -i | awk '{print $1}')
echo "pasv_address=$CONTAINER_IP" >> /etc/vsftpd.conf
echo "pasv_addr_resolve=NO" >> /etc/vsftpd.conf

# Start the vsftpd service
exec "$@"
