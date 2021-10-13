<div align="center">

![Cy Banner](assets/Cyriina_Banner.png?raw=true "Cy Banner")

<br>
<br>

# Cyriina's .dotfiles

I break things. **A lot.** Between local web developement, virtual machines, and my habit of acting first, thinking later, I got *really* tired of setting up new OS installs. So I decided to make it easier on myself with this repository.

<br>
<br>

🦇 **DISCLAIMER** 🦇
==============================
This is a very, very, very much work-in-progress thing. I've Frankenstein'd a bunch of snippets from other people's .dotfiles to create these. So many, in fact, that I'm not even sure of my sources, soooo if you see something you want to be credited for, let me know.

</div>

![Divider](assets/divider.png?raw=true "Divider")

## ☠️ Contents
<div style="padding: 15px; border: 2px solid transparent; margin-bottom: 20px; border-radius: 6px; color: #8319b8; background-color: #e3c6f1; border-color: #8319b8; width: 40%;">

- [Enable WSL](#enable-wsl)
- (Optional) [Windows Terminal](#windows-terminal)
- (Optional) [VSCode and WSL2](#vscode-and-wsl2)
- [Ubuntu Scripts](#ubuntu-scripts)
- [Auto Install](#auto-install)
- [Manual Install](#manual-install)
- [Xfce4 and xRDP](#xfce4-and-xrdp)
- [Fonts](#fonts)
- [Helpful Links](#helpful-links)
- [To-Do](#to-do)
- [License](#license)
</div>

I use Ubuntu | WSL2 running on Windows 10. Some of these scripts and options may not work out of the box for you. Sorry.

_____
<br>
<br>

<details>
<summary>If you need to install WSL2 (or upgrade from WSL1), start here.</summary>

### ❶ Enable WSL

*[WSL development on GitHub](https://github.com/microsoft/WSL)*

Enable WSL 2 and update the linux kernel ([Source](https://docs.microsoft.com/en-us/windows/wsl/install-win10))

```powershell
# Open PowerShell as Administrator

# Enable WSL and VirtualMachinePlatform features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Download and install the Linux kernel update package
$wslUpdateInstallerUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$downloadFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$wslUpdateInstallerFilePath = "$downloadFolderPath/wsl_update_x64.msi"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($wslUpdateInstallerUrl, $wslUpdateInstallerFilePath)
Start-Process -Filepath "$wslUpdateInstallerFilePath"

# Set WSL default version to 2
wsl --set-default-version 2
```

#### ❷ Choose an Ubuntu Distro from the Microsoft Store

- [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6)
- [Ubuntu 20.04](https://www.microsoft.com/en-us/p/ubuntu-2004-lts/9n6svws3rx71)
- [Ubuntu 18.04](https://www.microsoft.com/en-us/p/ubuntu-1804-lts/9n9tngvndl3q)
- [Ubuntu 16.04](https://www.microsoft.com/en-us/p/ubuntu-1604/9pjn388hp8c9)

#### ❸ Set Up Ubuntu User

Boot the Ubuntu app you just installed and follow any instructions to setup your Ubuntu user profile.

Update Ubuntu deps with: `sudo apt-get update && sudo apt-get upgrade`

#### ❹ Set Default Ubuntu Distro

If you installed more than one version of Ubuntu, or you plan on installing others in the future, go ahead and set the default distro you want being used.

```powershell
# Open PowerShell as Administrator

# wsl --set-version <Distro> <WSL Version>
wsl --set-version Ubuntu-20.04 2

# Validate the correct WSL version is being used:
wsl --list --verbose
```

#### ❺ Windows Terminal

*[Windows Terminal development on GitHub](https://github.com/microsoft/terminal)*

Microsoft's [Terminal app](https://www.microsoft.com/store/productId/9N0DX20HK701) is a modern terminal app designed for seamless integration between Windows and WSL, including support for different shells, custom themes, tabs and unicode (read emoji).

#### ❻ VSCode and WSL2
*[VSCode remote server development on GitHub](https://github.com/microsoft/vscode-remote-release)*
With VSCode's remote server feature, it has native support for WSL. You can run `code .` (or `code-insiders .` if you're using the Insiders version) from within a folder in any terminal, and VSCode makes the magic happen. See the [docs for further information](https://code.visualstudio.com/docs/remote/wsl).

#### ❼ Next Steps

At this point, you should have WSL2 working and an Ubunto distro installed. If your Ubuntu user is set up and your terminal is ready to go, follow the rest of the guide below.
</details>

_____
	
<br>
<br>
	
### 🦴 Ubuntu Scripts

Items installed in the following scripts include:

<div align="center">

**`fresh-install.sh`**

[`Git`](https://git-scm.com/) ✰ [`Github Cli`](https://cli.github.com/) ✰ [`Python 2 & 3`](https://www.python.org/downloads/) ✰ [`SSH`](https://www.openssh.com/) ✰ [`NVM`](https://github.com/nvm-sh/nvm) ✰ [`NodeJS`](https://nodejs.org/en/) ✰ [`Yarn`](https://yarnpkg.com/) ✰ [`PostgreSQL`](https://www.postgresql.org/) ✰ [`Docker`](https://www.docker.com/) ✰ [`Heroku`](https://www.heroku.com) ✰ [`AWS Cli`](https://aws.amazon.com/cli/) ✰ [`NGINX`](https://www.nginx.com/) ✰ [`Powerline Fonts`](https://github.com/powerline/fonts) ✰ [`Figlet`](http://www.figlet.org/) ✰ [`LOLcat`](https://github.com/busyloop/lolcat)

</div>
	
_____
	
<br>
<br>

## 🤖 Auto Install
![lolcat](assets/lolcat.png?raw=true "lolcat")

<details>
<summary>If you like things easy, but possibly broken, start here</summary>

1. Clone the repository into the `sources` directory:
    ```shell
    cd ~ && git clone https://github.com/Grimmstar/.dotfiles ~/sources/dotfiles
    ```

2. Run the `fresh-install.sh` script:
    ```shell
    ~/sources/dotfiles/fresh-install.sh
    ```
</details>

_____
	
<br>
<br>
	
## 🗡️ Manual Installation

<details>
<summary>Don't want to break things? Here is a safe place to start</summary>

- Open `fresh-install.sh` and copy/paste the commands you wish to use from top to bottom. I mean, that's the simplest way I can put it.
</details>

_____
	
<br>
<br>
	
#### 🧚 Xfce4 and xRDP

<details>
<summary>To access a Linux GUI from Windows with Xfce4 and xRDP, follow the instructions below</summary>

#### Download and install Xfce4 and the xRDP server
In a WSL terminal, run the following command:
```bash
# This is going to take *awhile*. Patience is a virtue.
sudo apt-get -y install xfce4 && sudo apt-get -y install xubuntu-desktop

# xRDP
sudo apt-get -y install xrdp
```

#### Configure xRDP for xfce4 and restart
```bash
# configure
echo xfce4-session > ~/.xsession

# restart
sudo service xrdp restart
```

#### Note the WSL IP address
```bash
ifconfig | grep inet
```

At this point, you should be able to open an RDP session from Windows 10.
- Open a `cmd` prompt and run `mstsc`
- Provide the WSL IP address
- (Optional) Provide your login info
- Connect the remote desktop

</details>

_____
	
<br>
<br>
	
## 🔮 Extras

##### Terminal card
<div align="center">

**`~/.dotfiles/extras/cyriinagrimm`**

![Cy Card](assets/terminal_card.png?raw=true "Cy Card")
</div>

##### MOTD/Login Banner
<div align="center">

**`~/.dotfiles/extras/MOTD`**

![Preview](assets/cy_motd.png?raw=true "Preview")
</div>

_____
	
<br>
<br>
	
## 🕵️ Fonts

<details>
	<summary>Free, monospaced fonts</summary>
- [Microsoft's Cascadia Code with Powerlines](https://github.com/microsoft/cascadia-code): mono, ligatures, free
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/#how-to-install): mono, ligatures, free
- [Fira Code](https://github.com/tonsky/FiraCode): mono, ligatures, free
- [Anomaly Mono](https://github.com/benbusby/anomaly-mono): mono, free
- [Hack](https://github.com/source-foundry/Hack): mono, free
- [Source Code Pro](https://www.1001fonts.com/source-code-pro-font.html): mono, ligatures, free
- [Anonymous Pro](https://www.1001fonts.com/anonymous-pro-font.html): mono, ligatures, free
- [Software Tester 7](https://www.1001fonts.com/software-tester-7-font.html): mono, free
- [NovaMono](https://www.1001fonts.com/novamono-font.html): mono, ligatures, free

</details>

_____
	
<br>
<br>
	
## 🕸️ Helpful Links

See [Credits](credits.md "Credits")
<br>

_____
	
<br>
<br>
	
## ✏️ To-Do
- [ ] Clean up dotfiles (`.bashrc`, `.profile`, `.bash_profile`, etc) to remove uneeded/unused/duplicate things
- [ ] Better way to auto-start services
- [ ] Dracula color theme for LS
- [ ] Better way to source dotfiles

_____

###### License

[MIT License](LICENSE) © [Cyriina Grimm](https://github.com/Grimmstar/)
