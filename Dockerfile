FROM ubuntu:17.04

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install git -y \
    && cd / \
    && git clone https://github.com/ErshKUS/OpenStreetMap.ru.git \
    && cd /OpenStreetMap.ru
