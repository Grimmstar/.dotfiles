#!/usr/bin/env bash
#---------------------------------------------------------------------------------------------
#
#  ██████╗ ██████╗ ██╗███╗   ███╗███╗   ███╗███████╗████████╗ █████╗ ██████╗
# ██╔════╝ ██╔══██╗██║████╗ ████║████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██╔══██╗
# ██║  ███╗██████╔╝██║██╔████╔██║██╔████╔██║███████╗   ██║   ███████║██████╔╝
# ██║   ██║██╔══██╗██║██║╚██╔╝██║██║╚██╔╝██║╚════██║   ██║   ██╔══██║██╔══██╗
# ╚██████╔╝██║  ██║██║██║ ╚═╝ ██║██║ ╚═╝ ██║███████║   ██║   ██║  ██║██║  ██║
#  ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝     ╚═╝╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
#
#---------------------------------------------------------------------------------------------
#
#    start_services.sh
#        Used to auto-start Docker, Postgres, and Nginx every time Windows is signed in to.
#
#    Source:
#       [Cyriina's .dotfiles](https://github.com/Grimmstar/.dotfiles)
#
#    Authors:
#       Cyriina Grimm <xxgrimmchildxx@gmail.com>
#
#---------------------------------------------------------------------------------------------

if ps ax |grep -v grep | grep 'postgresql' > /dev/null
then
  echo 'Postgres is already running'
else
  service postgresql start
fi

if ps ax |grep -v grep | grep 'docker' > /dev/null
then
  echo 'Docker is already running'
else
  service docker start
fi

if ps ax |grep -v grep | grep 'nginx' > /dev/null
then
  echo 'Nginx is already running'
else
  service nginx start
fi