# Workflow

## Environment variables

```sh
unset HISTFILE
export RESTIC_PASSWORD='<super-secret-password>'
export RESTIC_REPOSITORY='<repository>'
export B2_ACCOUNT_ID='<account-id>'
export B2_ACCOUNT_KEY='<account-key>'
```

## Initialize repo (first time only)

```sh
restic init
```

## Backup

```sh
restic backup /compose /var/lib/docker/volumes
```

## Restore

```sh
restic restore latest --target /
```
