#!/bin/bash


mkdir -p $HOME/.config/nvim >/dev/null
cp ./init.vim ~/.config/nvim

echo "[+] Installing pip"
curl https://bootstrap.pypa.io/get-pip.py -vs | python3

pip install virtualenv
