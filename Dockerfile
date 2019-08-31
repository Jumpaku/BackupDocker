FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    cron \
    nextcloud-desktop-cmd \
&& rm -rf /var/lib/apt/lists/*

ENV CRON_EXP="0 0 * ? * * *"
ENV CRON_USER="root"

COPY ./sync-exclude.lst /sync-exclude.lst 
COPY ./entrypoint.sh /entrypoint.sh

CMD [ "/entrypoint.sh" ]
