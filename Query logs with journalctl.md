# Query logs with journalctl

Man page: [journalctl](https://freedesktop.org/software/systemd/man/journalctl.html)

## Values

### Priority levels

* 0 = emergency
* 1 = alert
* 2 = critical
* 3 = error
* 4 = warning
* 5 = notice
* 6 = info
* 7 = debug

### Time formats

* yesterday
* today
* now
* tomorrow
* "YYYY-MM-DD HH:MM:SS"

## Common commands

| Command            | Description          |
|------------------- | -------------------- |
| journalctl -b      | Show logs from current boot |
| journalctl -b -1   | Show logs from last boot |
| journalctl -f      | Show latest logs and follow new log entries |
| journalctl -b -p=3 | Show logs from current boot with priority level 3 (errors) |
| journalctl --since "***time***" --until "***time***" | Show logs since, until or between time |
| journalctl _PID=***process-id*** | Show logs for specific process |
| journalctl -u sshd | Show logs for specific unit |
| journalctl /usr/bin/sshd | Show logs for specific executable |
