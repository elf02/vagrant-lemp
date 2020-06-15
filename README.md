# LAMP stack

* hashicorp/bionic64
* nginx
* mysql 5.7 (PW: root/root)
* php 7.4
* Redis
* node 12, composer
* git, curl...

[Installing MailHog for Ubuntu 16.04](https://www.lullabot.com/articles/installing-mailhog-for-ubuntu-1604)

Timezone for Ubuntu & PHP
* sudo timedatectl set-timezone Europe/Berlin
* php.ini -> date.timezone = "Europe/Berlin"

Optional
* disable OPCache -> opcache.ini -> opcache.enable=0

SSL Cert

```shell
sudo apt-get update
sudo apt-get install -y openssl
sudo mkdir -p /etc/nginx/certs/self-signed/
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/self-signed/domain.test.key -out /etc/nginx/certs/self-signed/domain.test.crt -subj "/C=DE/ST=Berlin/L=Berlin/O=Development/OU=Dev/CN=domain.test"
sudo openssl dhparam -out /etc/nginx/certs/dhparam.pem 2048
```

```shell
server {
    listen 443 ssl;
    index index.php index.html;
    server_name domain.test;
    error_log  /var/log/nginx/error-ssl.log;
    access_log /var/log/nginx/access-ssl.log;
    root /var/www/html;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }

    ssl_certificate /etc/nginx/certs/self-signed/domain.test.crt;
    ssl_certificate_key /etc/nginx/certs/self-signed/domain.test.key;
    ssl_dhparam /etc/nginx/certs/dhparam.pem;
}
```
