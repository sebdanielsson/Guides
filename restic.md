# Restic backup to S3 storage

## Intialize repo
```
export RESTIC_REPOSITORY='s3:<URL-TO-BUCKET>'
export AWS_ACCESS_KEY_ID='<AWS_ACCESS_KEY_ID>'
export AWS_SECRET_ACCESS_KEY='<AWS_SECRET_ACCESS_KEY>'
export RESTIC_PASSWORD='<ENCRYPTION-PASSWORD>'
restic init
```

## Backup to repo
```
restic --verbose backup <foldertobackup>
```

## List snapshots
```
restic --verbose snapshots
```

## Remove snapshot
```
restic --verbose forget <snapshot>
```

## Check integrity of all snapshots and packs
```
restic --verbose check --read-data
```

## Restore files
```
restic --verbose restore <snapshot> <dir-to-restore-to>
```