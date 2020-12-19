FROM openjdk:8-jre-slim

MAINTAINER Alexander Diaz <alexanderdiaz.dev>

# dependencies
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt -y update && apt -y install git curl tar ca-certificates openssl sqlite fontconfig tzdata iproute2

# setup user home/workdir
RUN useradd -d /home/container -m container
ENV USER=container HOME=/home/container

# switch to user
USER container

# workdir setup
WORKDIR /home/container/server
# Dockerfile copy is more just for the records than actual use
COPY ./Dockerfile /Dockerfile
COPY ./entrypoint.sh /entrypoint.sh

# Permissions
USER root
RUN chown -R container:container /home/container
USER container

# expose minecraft
EXPOSE 25565:25565

CMD [ "/bin/bash", "/entrypoint.sh" ]