# 🔴 NPM Cheat Sheet
*Source: [https://github.com/cheat/cheatsheets]*

*Every command shown here can be used with the `-g` switch for global scope*
## 🔴 Install
### To install a package in the current directory:
    npm install <package>

### To install a package, and save it in the `dependencies` section of `package.json`:
    npm install --save <package>

### To install a package, and save it in the `devDependencies` section of `package.json`:
    npm install --save-dev <package>

## 🔴 Check
### To show outdated packages in the current directory:
    npm outdated

## 🔴 Update
### To update outdated packages:
    npm update

### To update `npm` (will override the one shipped with Node.js):
    npm install -g npm

## 🔴 Uninstall
### To uninstall a package:
    npm uninstall <package>