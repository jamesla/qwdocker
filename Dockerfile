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

#UPDATE SERVER
WORKDIR /home/ubuntu/nquakesv
RUN ./update_binaries.sh --random-mirror --no-restart
RUN ./update_maps.sh --random-mirror --no-restart 
RUN ./update_configs.sh --random-mirror --no-restart 

#SCHEDULE UPDATES
USER root
RUN echo "30 5 * * 2 /home/quake/nquakesv/update_maps.sh --random-mirror --no-restart >/dev/null 2>&1" >> /etc/cron.daily/update.sh
RUN echo "30 5 * * 2 /home/quake/nquakesv/update_configs.sh --random-mirror --no-restart >/dev/null 2>&1" >> /etc/cron.daily/update.sh
RUN echo "30 5 * * 2 /home/quake/nquakesv/update_binaries.sh --random-mirror --no-restart >/dev/null 2>&1" >> /etc/cron.daily/update.sh
USER quake

#START THE SERVER
EXPOSE 28501
CMD ./run/ktx.sh
