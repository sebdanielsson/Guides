# Enable 2FA on Cockpit

Install google-authenticator

``` sh
sudo dnf install google-authenticator
```

Install chrony

``` sh
sudo dnf install chrony
```

Start and enable chrony

``` sh
sudo systemctl enable --now chronyd
```

Setup a secret key. You'll receive an OTP secret, QR-code to easily scanning it from your phone and some backup codes. Setup your TOTP app, for example 1Password, Google Authenticator or Microsoft Authenticator.

``` sh
google-authenticator -t -d -W -f -r 3 -R 30
```

Enable google-authenticator by add the following to `/etc/pam.d/cockpit`

``` sh
auth required pam_google_authenticator.so
```

Restart Cockpit

``` sh
systemctl restart cockpit
```
