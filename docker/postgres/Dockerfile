FROM postgres:14.0-bullseye

ENV UNAME=user
ENV GID=1000
ENV UID=1000

RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -G sudo -o -s /bin/bash $UNAME
RUN echo "$UNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers



# RUN apk update && apk add curl
# RUN curl -O https://ftp.postgresql.org/pub/projects/pgFoundry/dbsamples/world/world-1.0/world-1.0.tar.gz
# RUN tar -zxvf ./world-1.0.tar.gz
