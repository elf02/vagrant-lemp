#!/usr/bin/env bash

Update () {
    echo "-- Update packages --"
    sudo apt-get update
    sudo apt-get upgrade
}
Update

echo "-- Prepare configuration for MySQL --"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"

echo "-- Install tools and helpers --"
sudo apt-get install -y --force-yes python-software-properties htop curl git npm build-essential libssl-dev zip unzip

echo "-- Install PPA's --"
sudo add-apt-repository ppa:ondrej/php
sudo add-apt-repository ppa:chris-lea/redis-server
Update

echo "-- Install NodeJS --"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

echo "-- Install packages --"
sudo apt-get install -y --force-yes nginx mysql-server-5.7 git-core nodejs redis-server
sudo apt-get install -y --force-yes php7.4-common php7.4 php7.4-fpm php7.4-json php7.4-mysql php7.4-gd php7.4-curl php7.4-zip php7.4-xml php7.4-mbstring php7.4-opcache php7.4-cli php7.4-bcmath
Update

echo "-- Install Composer --"
curl -s https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo "-- Setup databases --"
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION; FLUSH PRIVILEGES;"
