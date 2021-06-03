# Enable 2FA on Cockpit

Install
```
sudo dnf install google-authenticator
```

Setup a secret key. You'll receive an OTP secret, QR-code to easily scanning it from your phone and some backup codes. Setup your TOTP app, for example 1Password, Google Authenticator or Microsoft Authenticator.
```
google-authenticator -t -d -W -f -r 3 -R 30
```

Enable google-authenticator by add the following to `/etc/pam.d/sshd`
```
auth required pam_google_authenticator.so
```

Configure SSHD
```
sed -i 's/PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/ChallengeResponseAuthentication.*/ChallengeResponseAuthentication yes/' /etc/ssh/sshd_config
```

Restart
```
systemctl restart sshd
```