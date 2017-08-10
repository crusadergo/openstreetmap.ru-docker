FROM ubuntu:17.04

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install git dialog -y \
    && git clone https://github.com/ErshKUS/OpenStreetMap.ru.git /var/www/osmru

# Install project dependencies
RUN apt-get install -y apache2 \
    && apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-curl

# Prepare to run
ADD htaccess /etc/apache2/sites-available/osmru.conf
RUN a2ensite osmru \
    && a2enmod rewrite \
    && cd /var/www/osmru \
    && mkdir -p www/api \
    && echo "Redirect /api/ http://openstreetmap.ru/api/" > www/api/.htaccess

EXPOSE 8000

CMD service apache2 restart \
    && sleep infinity
