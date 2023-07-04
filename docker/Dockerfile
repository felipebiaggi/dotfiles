FROM ubuntu:22.04

ENV TZ=America/Brazil
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -y tzdata

COPY install/setup.sh ./usr/local/bin/

COPY alacritty/alacritty.yml ./usr/local/bin/

RUN ["/usr/local/bin/setup.sh"]



