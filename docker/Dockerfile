FROM ubunt:22.04

ENV TZ=America/Brazil
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update
RUN apt install -y tzdata

RUN apt update && \
    apt -y install \
    git \
    neovim \
    curl && \
    apt autoremove -y

