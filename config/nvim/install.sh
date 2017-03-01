#!/bin/bash -e

#Install vim-plug if we don't already have it
if [ ! -e ~/.config/nvim/autoload/plug.vim ]; then
  # Ensure all needed directories exist  (Thanks @kapadiamush)
  mkdir -p ~/.config/nvim/plugged
  mkdir -p ~/.config/nvim/autoload
  # Download the actual plugin manager
  curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

  vim -E -s <<-EOF
    :PlugInstall
    :PlugClean
    :qa
EOF
fi

# Install dot files for neovim
# 
NVIM=~/.config/nvim
SPELL=$NVIM/spell
# Check if ~/.config/nvim/config/ exist. If not, create it

if [ ! -e "$NVIM/config" ]; then
    # Install config
    echo "Creating $NVIM"
    mkdir -p $NVIM/config
fi

if [ ! -e ~/.config/nvim/init.vim ]; then
  ln -s $PWD/init.vim ~/.config/nvim/init.vim
fi

if [ ! -e ~/.config/nvim/config/init.vim ]; then
  ln -s $PWD/config/init.vim ~/.config/nvim/config/init.vim
fi

if [ ! -e ~/.config/nvim/config/options.vim ]; then
  ln -s $PWD/config/options.vim ~/.config/nvim/config/options.vim
fi

if [ ! -e ~/.config/nvim/config/plugins.vim ]; then
  ln -s $PWD/config/plugins.vim ~/.config/nvim/config/plugins.vim
fi

if [ ! -e "$SPELL" ]; then
	echo "Creating spell directory..."
	#mkdir -p $SPELL
  	echo "Copying content of spell..."
	cp -r "$PWD/spell/" "$SPELL"
fi

echo "Done!!!"
