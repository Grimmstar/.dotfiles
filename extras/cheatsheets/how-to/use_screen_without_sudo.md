# How To:
## Use `screen` without `sudo`
*Source:* [GrimmStar](https://github.com/Grimmstar/.dotfiles)

#### ⭐ Is `screen` installed?
```
sudo apt-get install screen
```

#### ⭐ Create the directory for `screen` to run from
*Notes:* You will also have to modify the permissions on the directory
```
mkdir ~/.screen && chmod 700 ~/.screen
```

#### ⭐ Setting the `env` variable
```
export SCREENDIR=$HOME/.screen
```

*Notes:* You should probably also add the `export` statement above to your `~/.bashrc` Don't forget to `source` the file to apply your changes.

