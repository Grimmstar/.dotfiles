# WSL Cheat Sheet
*Source: [https://github.com/spences10/cheat-sheets/]*

## Shutdown WSL

Localhost not working?

```bash
wsl --shutdown
```

## Change WSL Version

Change between WSL versions

```bash
# wsl --set-version <distro> 2
# example
wsl --set-version Debian 2
```

## Set the default version of WSL

When installing new Linux distros you can default them all to be WSL2
or or one:

```bash
wsl --set-default-version 2
```

## List installed WSL Distros

```bash
# wsl --list --verbose
wsl -l -v
```