# APT-Get Cheat Sheet
*Source: [https://github.com/chubin/cheat.sheets]*

Commandline interface to APT package management

#### Update the local database of available packages
    apt-get update

#### Upgrade installed packages
    apt-get upgrade

#### Upgrade all of the installed packages
    apt-get dist-upgrade

#### Clean out (completely) the follow locations of saved DEB files:
#####   /var/cache/apt/archives/* /var/cache/apt/archives/partial/
#####   /var/lib/apt/lists/partial/
#####   /var/cache/apt/pkgcache.bin /var/cache/apt/srcpkgcache.bin
    apt-get clean -s

#### View the changelog for the firefox package.
##### Useful prior to or after upgrade.
    apt-get changelog firefox

#### Download PKG (one or more)
##### Without actually installing or extracting them
    apt-get download PKG

#### Install PKG (one or more)
##### Bringing in dependencies and, provided settings allow it, install recommended and/or suggested packages.
    apt-get install PKG

#### Force install
    apt-get -f install

#### Remove PKG, while also purging system-wide configuration files for it.
    apt-get purge PKG
#### Alternative syntax to the above.
    apt-get remove --purge PKG

#### Often used to first update the local database of packages
##### Only if successful, a full system upgrade is started.
    apt-get update && apt-get dist-upgrade

##### Download specified package (firefox, in this example) and all packages marked thereby as important or dependencies. Files are downloaded into the CWD.
    apt-get download firefox `apt-cache --important depends firefox |
        awk '{if(NR>1){printf("%s ", $2)}}'`