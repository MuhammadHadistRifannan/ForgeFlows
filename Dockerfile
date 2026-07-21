FROM php:8.2-fpm
WORKDIR /app
COPY . .

COPY composer*.json .
COPY composer*.lock .


RUN apt-get update && apt-get install -y openssl \
        libcurl4-openssl-dev \ 
        libzip-dev \
        libonig-dev \
        libxml2-dev \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    git \
    unzip \ 
    libzip-dev 

RUN docker-php-ext-install \
    bcmath \
    curl    \
    intl \
    gd \ 
    json \
    mbstring \
    pdo_mysql \
    tokenizer \ 
    xml\
    zip 

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY . .

RUN composer install

EXPOSE 9000
CMD [ "php-fpm" ]