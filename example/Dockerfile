FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt-get install -y cron curl
RUN echo '* * * * * root date >> /data/date.txt' > /etc/crontab

CMD ["cron", "-f"]
