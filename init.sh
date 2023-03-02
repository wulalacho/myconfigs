#*================================================================
#*   Copyright (C) 2023 Goodfanqie. All rights reserved.
#*   
#*   File   name：init.sh
#*   Created  by：Goodfanqie
#*   Create Date：2023.03.02.
#*   Description：
#*
#*================================================================*/


echo "#!/bin/bash
host_ip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
export ALL_PROXY="http://$host_ip:7890"" > .proxyrc;
echo "source $HOME/.proxyrc" >> .zshrc
source $HOME/.proxyrc

# 安装最新版的neovim
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim

# 安装最新版的nodejs
curl -sL https://deb.nodesource.com/setup_19.x | sudo -E bash -
sudo apt-get install -y nodejs

# 安装plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

