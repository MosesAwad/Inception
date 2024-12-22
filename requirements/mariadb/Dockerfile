FROM debian:bookworm

# -y flag tells apt-get to assume "yes" for all prompts and continue the operation without waiting for your manual input.
RUN apt-get update -y && apt-get install mariadb-server -y

# -p means that even if /run doesnt exist, go ahead and make /run with /mysqld alogn with it
RUN mkdir -p /run/mysqld && chmod 777 /run/mysqld

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/script.sh /script.sh

RUN chmod +x /script.sh

ENTRYPOINT ["sh", "script.sh"]

# I had to put --user=mysql as an argument because otherwise, mariadb gets run as root user by default and that is prevented due to security reasons
CMD ["mariadbd", "--user=mysql"]