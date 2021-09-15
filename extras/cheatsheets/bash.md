# Bash Cheat Sheet
*Source: [https://github.com/chubin/cheat.sheets], [https://github.com/spences10/cheat-sheets]*

## Bash keyboard shortcuts

### Navigation
```Ctrl + a   - go to beginning of line
Ctrl + e   - go to end of line
Ctrl + f   - one character forward
Ctrl + b   - one character backward
 Alt + f   - one word forward
 Alt + b   - one word backward
Ctrl + xx  - toggle between start of line and current position
```

### Editing
```Ctrl + d   - delete character right (Del)
Ctrl + h   - delete character left (Backspace)
 Alt + d   - cut word right
Ctrl + w   - cut word left
Ctrl + k   - cut from cursor till end of line
Ctrl + u   - cut from beginning of line till cursor
Ctrl + y   - paste last cut
 Alt + t   - swap current word with previous
Ctrl + t   - swap current character with previous
 Alt + u   - uppercase from cursor till end of word
 Alt + l   - lowercase from cursor till end of word
 Alt + c   - capitalize current word
Ctrl + v   - insert next character literally (e.g. Ctrl + v - Tab)
Ctrl + _   - undo last action
 Alt + r   - revert all modifications to current line
 Tab       - complete file/command name
 ```

### History
```Ctrl + r   - interactive history search
Ctrl + g   - escape from interactive history search
Ctrl + p   - previous command (↑)
Ctrl + n   - next command (↓)
Ctrl + o   - execute displayed command from history, don't clear command line
 Alt + .   - recall last argument (word) of last executed command
```

### Terminal control
```Ctrl + l   - clear screen, don't clear command line
Ctrl + s   - suspend (freeze) terminal
Ctrl + q   - unsuspend (unfreeze) terminal
Ctrl + z   - suspend (SIGSTP) current process. Resume with 'fg' (foreground)
             or 'bg' (background), kill with 'kill %<ID>'
Ctrl + d   - send EOF
```

### Human Readable `$PATH` output
Use this to nicely format the `$PATH` variable:
```bash
echo -e ${PATH//:/\\n}
```

### Change default shell
Use `chsh` utility to change your default shell:
```bash
# list out the shells available with -l
chsh -l
# if that doesn't work try
cat /etc/shells
# /bin/bash
# /bin/zsh
# /bin/fish
# set the default shell (with -s) to fish
chsh -s /bin/fish
# set the default shell (with -s) to zsh
chsh -s /bin/zsh
```

### Kill process on port
List any process running on port 8000#
```bash
lsof -i:8000
```

Output will look similar to this.

```text
COMMAND   PID  USER
chrome  16085  iamuser
```

Then kill it with `kill`.

```bash
kill -9 16085
```

### Add an alias
```bash
# open your bash_profile with nano
nano ~/.bash_profile
# add your alias
alias f='fish'
# ctrl+x then y to save
```

### Sort alphabetically
You may find that commands like `ll` are under your `~/.bashrc` file,
if not then add the following as an alias:
```bash
ls -lart | sort -k9,9
```

### See file permissions
If you need to set the permission on a file (with `chmod`) but don't
know what the permissions of similar files are like you can use
`stat`, the following command displays the permissions of the contents
of the `.ssh/` folder:
```bash
stat -c "%a %n" ~/.ssh/*
```

### Open the SSH agent each time you open a new terminal.
Tired of having to enter your SSH password each time you want to do a
git operation?

Add the following to your `~/.bashrc` file.
```bash
# nano ~/.bashrc
[ -z "$SSH_AUTH_SOCK" ] && eval "\$(ssh-agent -s)"
```

### Search Bash history
Want to search for an entry in your Bash history?

Use `Ctrl+r` then enter your search term.

### Remove command from bash history
Accidentally added your password as a bash command?

To remove that from the bash history:
```bash
# list out history with
history
```

Then take the number from the output:
```bash
471  ssh-agent
472  exit
473  kill 53111
474  super secret password
475  history
```

Then delete the line you want removed:

```bash
history -d 474
```

Check your `history` again and gone until you do it again.

### Move the contents of a folder to another folder
This will move everything in the Downloads folder to the Videos folder
including any folders inside Downloads.
```bash
mv ~/Downloads/* ~/Videos
```

## Keyboard shortcuts

You can find complete lists of Bash shortcuts elsewhere. I only write down those I'm trying to learn...

| Shortcut | Task                                                         |
| :---     | :---                                                         |
| `Ctrl-O` | Execute current line from history, on return gives next line |
| `Ctrl-U` | Delete from cursor to beginning of line                      |
| `Meta-*` | Insert all possible command line completions                 |

**Bang!

| Command |                                   |
| :---    | :---                              |
| `!!`    | Previous command                  |
| `!$`    | Last argument of previous command |
| `!*`    | All arguments of previous command |

## .inputrc

The file `~/.inputrc`, if it exists, controls the behaviour of `GNU readline` and affects many interactive programs, e.g. Bash, Python shell, etc. An example configuration:

```bash
# /etc/inputrc
"\C-p":history-search-backward
"\C-n":history-search-forward

set colored-stats On
set completion-ignore-case On
set completion-prefix-display-length 3
set mark-symlinked-directories On
set show-all-if-ambiguous On
set show-all-if-unmodified On
set visible-stats On
```

## Resources

- Levy, J. (2019) *The Art of Command Line.* Retrieved 2020-04-14 from <https://github.com/jlevy/the-art-of-command-line>
- Rouberol, B. (2020-04-24) *Shell productivity tips and tricks.* Retrieved 2020-06-26 from <https://blog.balthazar-rouberol.com/shell-productivity-tips-and-tricks>
