# Enable 2FA on Cockpit

Install google-authenticator
```
sudo dnf install google-authenticator
```

Setup a secret key. You'll receive an OTP secret, QR-code to easily scanning it from your phone and some backup codes. Setup your TOTP app, for example 1Password, Google Authenticator or Microsoft Authenticator.
```
google-authenticator -t -d -W -f -r 3 -R 30
```

Enable google-authenticator by add the following to `/etc/pam.d/cockpit`
```
auth required pam_google_authenticator.so
```

Restart Cockpit
```
systemctl restart cockpit
```