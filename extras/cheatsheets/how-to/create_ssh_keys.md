# How To:
## Set Up SSH Keys
*Source:* [GrimmStar](https://github.com/Grimmstar/.dotfiles)

### Check for old keys

```shell
ls -l ~/.ssh/id_*.pub
```

### Generate new keys

```shell
ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"
```

### Verify key creation

```shell
ls ~/.ssh/id_*
```

### (Optional) Copy/Paste the key wherever

```shell
cat ~/.ssh/id_rsa.pub | ssh remote_username@server_ip_address "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
```
