# SSH Public Key Authentication

**Generate a key pair locally**
```
ssh-keygen -f ~/.ssh/id_ed25519 -t ed25519
```

**Copy your public key to the remote SSH servers** `~/.ssh/authorized_keys`
```
ssh-copy-id -i ~/.ssh/id_ed25519.pub sebastian@0.0.0.0
```

**Edit your SSH client to use your new key as your identity `~/.ssh/config`**
```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

**Add the key to the SSH agent**
```
ssh-add -K ~/.ssh/id_ed25519
```

**Edit your remote SSH server config `/etc/ssh/sshd_config`**
```
PermitRootLogin prohibit-password
PasswordAuthentication no
```

```
systemctl reload sshd.service
```

**Bonus:** We can specify SSH aliases like this: `ssh hogwarts`
To do this we need to add the host to our `~/.ssh/config`
```
Host hogwarts
  HostName 0.0.0.0
  User sebastian
  IdentityFile ~/.ssh/id_ed25519
  IdentitiesOnly yes
```