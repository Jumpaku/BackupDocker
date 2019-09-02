# backup-with-nextcloud

Docker image to backup files with remote nextcloud.

## Introduction

* It synchronizes created files with the specified remote nextcloud server.
* It can prepare backup files by executing the specified script.
* It repeats these processes with cron.

## Volumes

### `/backup/`

This container synchronizes the files in the directory named `/backup/` with nextcloud.
Mount the directory of your host which contains the files which you want to backup to `/backup/` of this container.

### `/backup.sh`

This container can execute complex processes to prepare files which are backed up.
If you want to execute complex processes, create a script which put files to be backed up to `/backup/` and mount the script to `/` as `backup.sh`.


## Environments

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

the following `/etc/crontab` is generated.

```
0  *  *  *  * root /backup.sh && nextcloudcmd --user nc_user --password nc_password /backup/ http://nextcloud/remote.php/webdav/
```


## Examples for docker-compose

Execute `docker-compose up -d` with the following `docker-compose.yml`.

* docker-compose.yml

```yml
version: '3'

services: 
  backup:
    image: 'jumpaku/backup-with-nextcloud'
    environment: 
      - 'NC_URL=http://nextcloud.example.com/remote.php/webdav/'
      - 'NC_USER=nc_user'
      - 'NC_PASSWORD=nc_password'
    volumes: 
      - './backup/:/backup/'
```

Or execute `docker-compose up -d` with the following `docker-compose.yml` and `backup.sh`.

* docker-compose.yml

```yml
version: '3'

services: 
  backup:
    image: 'jumpaku/backup-with-nextcloud'
    environment: 
      - 'NC_URL=http://nextcloud.example.com/remote.php/webdav/'
      - 'NC_USER=nc_user'
      - 'NC_PASSWORD=nc_password'
    volumes: 
      - './backup.sh:/backup.sh:ro'
      - './backup-from/:/backup-from/'
```

* backup.sh

```sh
#!/bin/bash
cp -rf /backup-from/* /backup/
```
