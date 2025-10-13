# SSH KEYS

```bash
## Generate new key
ssh-keygen -t ed25519 -C "email@example.com" -f ~/.ssh/id_ed25519

## Generate RSA key (legacy, 4096-bit)
ssh-keygen -t rsa -b 4096 -C "email@example.com" -f ~/.ssh/id_rsa

## Start ssh-agent
eval "$(ssh-agent -s)"

## Add key to ssh-agent
ssh-add ~/.ssh/id_ed25519

## List keys in ssh-agent
ssh-add -l

## Test SSH connection (GitHub/GitLab)
ssh -T git@github.com
ssh -T git@gitlab.com

## Remove key from ssh-agent
ssh-add -d ~/.ssh/id_ed25519

## Remove all keys from ssh-agent
ssh-add -D

## Change passphrase of existing key
ssh-keygen -p -f ~/.ssh/id_ed25519
```

### SSH -> GIT
```bash
# config path: (~/.ssh/config)
# remotes like gh:username/repo
Host gh 
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ecdsa
    IdentitiesOnly yes
```
