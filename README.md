# BackupWithNextcloud

Docker image to backup files with nextcloud

## Introduction

It creates backup files by executing the specified script.
It synchronizes created files with the specified nextcloud server.
It repeats these processes with cron.

## Backup script

Mount the backup script `backup.sh` on `/` as follows:

```yml
    volumes: 
      - './backup.sh:/backup.sh:ro'
```

`backup.sh` needs to create a file to be backed up to `/backup/`.

## Environment

Configure environments.

| environment | default         | required | description |
|-------------|-----------------|----------|-------------|
| CRON_EXP    | `0 0 * ? * * *` | no       |             |
| CRON_USER   | root            | no       |             |
| NC_URL      |                 | yes      |             |
| NC_USER     |                 | yes      |             |
| NC_PASSWORD |                 | yes      |             |

From the following environments:

```yml
    environment: 
      - "CRON_EXP=0  *  *  *  *"
      - "CRON_USER=root"
      - "NC_URL=http://nextcloud/remote.php/webdav/"
      - "NC_USER=nc_user"
      - "NC_PASSWORD=nc_password"
```

the following `/etc/crontab` is generated

```
$CRON_EXP $CRON_USER /backup.sh && nextcloudcmd --user $NC_USER --password $NC_PASSWORD /backup/ $NC_URL
```
