#!/usr/bin/env bash
set -e
cp /etc/mysql/zzz-mysql.cnf /etc/mysql/conf.d/zzz-mysql.cnf
chmod 755 /etc/mysql/conf.d/zzz-mysql.cnf

exec /usr/local/bin/docker-entrypoint.sh "$@" &

# wait for mysql until it is ready
while ! mysqladmin ping --silent; do
    sleep 1
done

# create tables by directory names and impport .sql files
for file in `find /import/db/ -mindepth 2 -maxdepth 2 -type f -iname *.sql`
do
    dbname=`echo $file | awk -F "/" '{print $4}'`
    importeddir=`dirname $file`/imported
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $dbname DEFAULT CHARACTER SET = utf8mb4";
    mysql -u root $dbname < $file
    mkdir -p $importeddir
    mv $file $importeddir
done
tail -f /dev/null
