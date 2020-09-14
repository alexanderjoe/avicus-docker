FROM openjdk:8-jre-alpine

RUN     apk update \
    &&  apk add ca-certificates wget bash curl \
    &&  update-ca-certificates

ADD . /app

EXPOSE 25565:25565

RUN chmod a+x /app/run.sh

CMD /app/run.sh
