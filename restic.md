# Restic backup to S3 storage

## Intialize repo

``` sh
export RESTIC_REPOSITORY='s3:<URL-TO-BUCKET>'
export AWS_ACCESS_KEY_ID='<AWS_ACCESS_KEY_ID>'
export AWS_SECRET_ACCESS_KEY='<AWS_SECRET_ACCESS_KEY>'
export RESTIC_PASSWORD='<ENCRYPTION-PASSWORD>'
restic init
```

## Backup to repo

``` sh
restic --verbose backup <foldertobackup>
```

## List snapshots

``` sh
restic --verbose snapshots
```

## Remove snapshot

``` sh
restic --verbose forget <snapshot>
```

## Remove unnecessary data after snapshot deletion

``` sh
restic --verbose prune
```

## Check integrity of all snapshots and packs

``` sh
restic --verbose check --read-data
```

## Restore files

``` sh
restic --verbose restore <snapshot> <dir-to-restore-to>
```
