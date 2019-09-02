# backup-with-nextcloud

Docker image to backup files with nextcloud

## Introduction

It creates backup files by executing the specified script.
It synchronizes created files with the specified nextcloud server.
It repeats these processes with cron.

## Example

Run `docker-compose up -d` with the following `docker-compose.yml` and `backup.sh`.

* docker-compose.yml

```yml
version: '3'

services: 
  backup:
    container_name: 'backup'
    images: 'jumpaku/backup-with-nextcloud'
    volumes: 
      - './backup.sh:/backup.sh:ro'
      - './backup-from/:/backup-from/'
    environment: 
      - "NC_URL=http://nextcloud/remote.php/webdav/"
      - "NC_USER=testuser"
      - "NC_PASSWORD=user_password"
```

* backup.sh

```sh
cp -rf /backup-from/* /backup/
```

## Backup script

Mount the backup script `backup.sh` on `/` as follows:

```yml
    volumes: 
      - './backup.sh:/backup.sh:ro'
```

`backup.sh` needs to create a file to be backed up to `/backup/`.

## Environments

Configure environments.

| environment | default         | required | description |
|-------------|-----------------|----------|-------------|
| CRON_EXP    | `0  *  *  *  *` | no       | cron expression |
| CRON_USER   | root            | no       | user who execute cron command |
| NC_URL      |                 | yes      | url of Nextcloud's folder |
| NC_USER     |                 | yes      | user of Nextcloud |
| NC_PASSWORD |                 | yes      | password for the user of nextcloud |

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
0  *  *  *  * root /backup.sh && nextcloudcmd --user nc_user --password nc_password /backup/ http://nextcloud/remote.php/webdav/
```
