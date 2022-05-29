# Automation compose up/down

## docker compose up -d

```sh
for d in /compose/*/ ; do (cd "$d" && docker compose up -d); done
```

## docker compose down
```sh
for d in /compose/*/ ; do (cd "$d" && docker compose down); done
```
