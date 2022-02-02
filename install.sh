#!/bin/bash

if ! command -v pip >/dev/null; then
	echo "[+] Installing pip"
	curl https://bootstrap.pypa.io/get-pip.py -vs | python3
fi
pip install virtualenv


echo "[+] Installing via pacman."
sudo pacman -Sy --needed lsd zsh neovim xclip neofetch


echo "[+] Installing Plug-ins for nvim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p $HOME/.config/nvim >/dev/null
cp ./config/nvim/init.vim "$HOME/.config/nvim"
nvim --headless +PlugInstall +qa >/dev/null & disown
clear


echo "[+] Installing antibody"
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin


echo "[+] Configuring zsh"
mkdir -p "$HOME/.config/zsh"

mv "$HOME/.zshrc" "$HOME/.config/zsh/.zshrc.old"
cp ./config/zsh/* $HOME/.config/zsh/

printf 'source "$HOME/.config/zsh/zshrc"\ntypeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet\n' > "$HOME/.zshrc"
mkdir chroma
cd chroma
chroma_url=$(curl -s https://api.github.com/repos/alecthomas/chroma/releases | grep linux-amd64 | head -n 2 | tail -n 1 | cut -d '"' -f 4)
if [ ! $chroma_url ]; then echo "[-] Please install chroma from: https://github.com/alecthomas/chroma/releases" && xdg-open https://github.com/alecthomas/chroma/releases && exit; fi
wget $chroma_url
tar xvf chroma* >/dev/null
sudo mv ./chroma /usr/bin/chroma
rm COPYING README.md chroma*
cd .. && rm -rf chroma
