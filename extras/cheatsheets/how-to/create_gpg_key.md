# How To:
## Create GPG Keys
*Source:* [GrimmStar](https://github.com/Grimmstar/.dotfiles)

### Restore an old key
You may have already created a key before. Try restoring it before creating a new one, just in case.

    - On old system, create a backup of a GPG key
        + gpg --list-secret-keys
        + gpg --export-secret-keys {{KEY_ID}} > /tmp/private.key
    - On new system, import the key:
        + gpg --import /tmp/private.key
    - Delete the /tmp/private.key on both side

### Create a new key

    + gpg --full-generate-key
