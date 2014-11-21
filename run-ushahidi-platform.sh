#!/bin/bash -e

# Installs and run Ushahidi's platform tests

# Check if behat, phpunit and phpspec is installed
if [ ! -f "bin/phpspec" ] || [ ! -f "bin/behat" ] || [ ! -f "bin/phpunit" ]; then
    # Install behat
    echo "Installing testing tools..."
    curl http://getcomposer.org/installer | php
    php composer.phar install
fi

PSWD=password

# Grant DB access to root user
sed -i "s/'password'   => ''/'password'   => '$PSWD'/g" application/config/environments/testing/database.php

# Setup database
echo "Configuring databases"
mysql -h localhost -uroot -p$PSWD -e "SET GLOBAL sql_mode = 'STRICT_ALL_TABLES';"
mysql -h localhost -uroot -p$PSWD -e "DROP DATABASE IF EXISTS platform_test;"
mysql -h localhost -uroot -p$PSWD -e "CREATE DATABASE platform_test;"
mysql -h localhost -uroot -p$PSWD -e "DROP DATABASE IF EXISTS zombie2x;"
mysql -h localhost -uroot -p$PSWD -e "CREATE DATABASE zombie2x;"


echo "Importing test data"
ZOMBIE=/tmp/ushahidi-zombie2x.sql

if [ ! -e $ZOMBIE ] ; then
    wget https://72c9192a7b87de5fc63a-f9fe2e6be12470a7bff22b7693bc7329.ssl.cf1.rackcdn.com/lamu-ci-zombie2x.sql -O $ZOMBIE
else
    echo "Zombie data already exist"
fi

mysql -h localhost -u root -p$PSWD -D zombie2x < $ZOMBIE

echo "Changing permissions"
chmod 777 application/logs application/cache

echo "Moving behat config into place"
cp application/tests/behat.template application/tests/behat.yml

#bin/tests install

echo " Run Phinx migration"
bin/phinx migrate -c application/phinx.php

echo "bin/tests run --no-install"
bin/tests run --no-install

echo "bin/phpunit -c application/tests/phpunit.xml"
bin/phpunit -c application/tests/phpunit.xml