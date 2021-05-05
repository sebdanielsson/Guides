```
for d in /compose/*/ ; do (cd "$d" && docker-compose up -d); done

for d in /compose/*/ ; do (cd "$d" && docker-compose down); done
```