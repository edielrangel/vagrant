echo 'Instalando o Apache2'
cd ~ && sudo apt update && sudo apt install apache2 && sudo systemctl status apache2
echo 'Instalando o PHP8'
cd ~ && sudo apt-get install lsb-release apt-transport-https ca-certificates
cd ~ && sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
cd ~ && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
cd ~ && sudo apt update
cd ~ && sudo apt install php8.0 php8.0-intl php8.0-mysql php8.0-sqlite3 php8.0-gd php-xml php-mbstring
cd ~ && php -version
echo 'Instalando o MySql'
cd ~ && sudo apt update && sudo apt install gnupg && cd /tmp && wget https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb
cd /tmp && sudo dpkg -i mysql-apt-config* && sudo apt update && sudo apt install mysql-server && sudo systemctl status mysql
echo 'Instalando o COMPOSER'
cd ~ && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
cd ~ && php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
cd ~ && php composer-setup.php
cd ~ && php -r "unlink('composer-setup.php');"
cd ~ sudo mv composer.phar /usr/local/bin/composer
composer
echo 'Instalando o PhpMyAdmin (opcional): \n 1 - Sim \n 2 - Não'
read PMA
case $PMA in
    1) echo 'Instando....'
    cd /var/www/html && sudo composer create-project phpmyadmin/phpmyadmin --repository-url=https://www.phpmyadmin.net/packages.json --no-dev
    cd /var/www/html/phpmyadmin && composer update && sudo mkdir tmp/ && sudo chown -R www-data:www-data tmp/
    cd /var/www/html/phpmyadmin && sudo cp phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php
    cd /var/www/html/phpmyadmin && sudo rm -rf setup/
    
    ;;
    *) echo 'Próximo Passo'
    ;;
esac
echo 'Instalando o Certbot'
cd ~ && sudo apt install snapd && sudo snap install core; sudo snap refresh core && sudo snap install --classic certbot && sudo ln -s /snap/bin/certbot /usr/bin/certbot && sudo certbot --apache
