#!/bin/bash

if [ -z $NC_USER ]; then
    echo "environment NC_USER is required."
    exit 2
fi

if [ -z $NC_PASSWORD ]; then
    echo "environment NC_PASSWORD is required."
    exit 2
fi

if [ -z $NC_URL ]; then
    echo "environment NC_URL is required."
    exit 2
fi


echo "$CRON_EXP $CRON_USER /backup.sh && nextcloudcmd --non-interactive --user $NC_USER --password $NC_PASSWORD --exclude /sync-exclude.lst /backup/ $NC_URL" > /etc/crontab

cron -f
