# Dockerfile to run a linux quake world server
FROM ubuntu:16.04
MAINTAINER James McCallum <jamesgmccallum@gmail.com>

#UPDATE OS
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git unzip wget

#USER SETUP
RUN useradd -ms /bin/bash quake
WORKDIR /home/ubuntu
RUN chown -R quake:quake /home/ubuntu
USER quake

#GET FILES
RUN git clone https://github.com/marcusgadbem/nquakesv

#FILE PERMISSIONS
USER root
RUN chmod +755 nquakesv/start_qwfwd.sh
USER quake

#CONFIGS
COPY configs/ktx nquakesv/ktx
COPY configs/qwfwd nquakesv/qwfwd

#UPDATE SERVER
WORKDIR /home/ubuntu/nquakesv
RUN ./update_binaries.sh
RUN ./update_maps.sh
RUN ./update_configs.sh

#START THE SERVER
EXPOSE 28501
CMD ./start_servers.sh