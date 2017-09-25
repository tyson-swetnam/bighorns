#!/bin/bash

############################################
### Python Geographic Data Science Stack ###
############################################
git clone https://github.com/darribas/gds_env.git
cd gds_env
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh
chmod +x miniconda.sh
./miniconda.sh -b -p ./miniconda
export PATH=`pwd`/miniconda/bin:$PATH
conda update --yes conda
conda install --yes psutil yaml pyyaml
conda-env create -f install_gds_stack.yml

# more non GIS but programming stuff - optional, add your own stuff here
sudo add-apt-repository ppa:neovim-ppa/unstable # nvim: new version of vim

sudo apt-get update # see https://github.com/neovim/neovim/wiki/Installing-Neovim

sudo apt-get install -y neovim

sudo apt-get install -y zsh # nice evolution of bash

sudo apt-get install -y git-core # from https://www.thinkingmedia.ca/2014/10/how-to-install-oh-my-zsh-on-ubuntu-14/

# Now you can install Oh My Zsh.

sudo curl -L http://install.ohmyz.sh | sh

# done.
echo "all done"
echo "type 'rstudio-server start' in the terminal to start RStudio"
echo "type source activate gds_test before running Python in bash"
