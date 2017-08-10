FROM ubuntu:17.04

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install git dialog -y \
    && git clone https://github.com/ErshKUS/OpenStreetMap.ru.git /var/www/osm_ru

# Install project dependencies
RUN apt-get install -y apache2 \
    && apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-curl

# Prepare to run
ADD htaccess /etc/apache2/sites-available/osmru.conf
RUN a2ensite osmru \
    && cd /var/www/osm_ru \
    && mkdir -p www/api \
    && echo "Redirect /api/ http://openstreetmap.ru/api/" > www/api/.htaccess \
    && service apache2 restart

EXPOSE 8000

CMD phpup -p 8000 /var/www/osm_ru/www
