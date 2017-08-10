FROM ubuntu:17.04

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install git -y \
    && git clone https://github.com/ErshKUS/OpenStreetMap.ru.git /var/www/osm_ru

# Install project dependencies
RUN apt-get install -y apache2 libapache2-mod-php7.0 php7.0 php7.0-curl

# Prepare to run
RUN apt-get install -y wget \
    && wget https://raw.github.com/lox/phpup/master/phpup -O /usr/local/bin/phpup \
    && chmod +x /usr/local/bin/phpup \
    && cd /var/www/osm_ru \
    && mkdir -p www/api \
    && echo "Redirect /api/ http://openstreetmap.ru/api/" > www/api/.htaccess

EXPOSE 8000

CMD phpup -p 8000 /var/www/osm_ru/www
