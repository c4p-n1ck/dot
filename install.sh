#!/bin/bash


if ! command -v pip >/dev/null; then
	echo "[+] Installing pip"
	curl https://bootstrap.pypa.io/get-pip.py -vs | python3
fi
pip install virtualenv


if ! command -v nvim >/dev/null; then
	echo "[+] Installing neovim"
	wget $(curl -s https://api.github.com/repos/neovim/neovim/releases | grep stable | grep appimage | cut -d '"' -f 4 | head -n 1)
	chmod +x ./nvim.appimage && sudo mv ./nvim.appimage /bin/neovim
	sudo ln -s /bin/neovim /bin/nvim
	sudo ln -s /bin/neovim /bin/vim
fi


echo "[+] Installing Plug-ins for nvim"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -p $HOME/.config/nvim >/dev/null
cp ./init.vim ~/.config/nvim
nvim --headless +PlugInstall +qa 2>/dev/null
