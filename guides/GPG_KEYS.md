# GPG KEYS

```
## Generate new key
gpg --quick-generate-key "User Name <email@example.com>" ed25519 sign 0

## if pinentry error reload with
gpg-connect-agent reloadagent /bye

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

## REPO SCOPED
https://git-scm.com/docs/git-config.html#_variables
```bash
git config user.signingkey $KEY
git config user.username Name
git config user.email foo@mail.com

git config --global commit.gpgsign true


# for ssh
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub

git log --pretty=format:'%h %G? %s'

echo "mail@key.com $(cat ~/.ssh/key.pub)" >> allowed_signers
git config --global gpg.ssh.allowedSignersFile ~/.config/git/allowed_signers
```
