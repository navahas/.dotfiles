# GPG KEYS

```
## Generate new key
gpg --quick-generate-key "User Name <email@example.com>" ed25519 sign 0

## List keys
gpg --list-keys "User Name <email@example.com>"
gpg --list-secret-keys --keyid-format=long

## Edit key (add/remove identities)
gpg --edit-key $KEY
gpg> adduid   # add user ID
gpg> save
gpg> deluid   # delete user ID

## Export public key (ASCII armor)
gpg --armor --export $KEY

## Delete secret key
gpg --delete-secret-key $KEY

## Configure Git signing
git config --global user.signingkey $KEY

## Restart GPG agent
gpgconf --kill gpg-agent
```
