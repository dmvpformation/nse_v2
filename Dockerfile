FROM debian:bookworm

RUN apt-get update 
RUN apt-get install -y wget libzip-dev apt-transport-https lsb-release ca-certificates git curl software-properties-common
RUN apt-get -y install libxpm4 libxrender1 libgtk2.0-0 libnss3 libgconf-2-4
RUN apt-get -y install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils
RUN apt-get install -y g++ build-essential

### Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get install -y nodejs

### Install Redis
RUN apt-get install -y redis-server

### Install PHP
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main"> /etc/apt/sources.list.d/php.list
RUN apt-get update
RUN apt-get install --no-install-recommends -y php8.2 libapache2-mod-php8.2 php8.2-mysql php8.2-curl php8.2-gd php8.2-msgpack php8.2-memcached php8.2-intl php8.2-sqlite3 php8.2-gmp php8.2-mbstring php8.2-redis php8.2-xml php8.2-zip php8.2-soap php8.2-igbinary

### Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/bin/composer \
    && chmod +x /usr/bin/composer
RUN php -v

### Install YARN
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn
