#! /usr/bin/env bash

######### COLORS ########

RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
BOLDGREEN="\033[1;${GREEN}"
BOLDBLUE="\033[1;${BLUE}"
ENDCOLOR="\033[0m"

#########################


# Install Xcode
echo -e "${BOLDBLUE}Installing xcode-stuff${ENDCOLOR}"
xcode-select --install

read -p "${BOLDGREEN}Press [Enter] key when done installing xcode-stuff...${ENDCOLOR}"


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo -e "${BOLDBLUE}Updating homebrew...${ENDCOLOR}"
brew update

echo -e "${BOLDBLUE}Installing Git...${ENDCOLOR}"
brew install git

echo -e "${BOLDBLUE}Git config${ENDCOLOR}"
git config --global user.name "Marc Troesken"
git config --global user.email m.troesken@mail.de

######### Install brew tools ###########
echo -e "${BOLDBLUE}Installing other brew stuff...${ENDCOLOR}"
TOOLS=(
  "tree"
  "wget"
  "nvim"
  "fd"
  "gd"
  "lazygit"
  "python@3.9"
  "python-yq"
  "minamijoyo/hcledit/hcledit"
  "ripgrep"
  "hcledit"
)

brew install ${TOOLS[@]}

####### Set Python3 as standard ########
sudo mkdir /usr/local/bin
sudo ln -s -f $(which python3) /usr/local/bin/python
python3 -m ensurepip

# Cloud Stuff
brew install tfenv && TFENV_ARCH=arm64 tfenv install 1.1.8 && tfenv use 1.1.8

####### Install nvm and copy configs ########
brew install nvm

nvm install 20
npm install -g neovim

echo -e "${GREEN}Cleaning up brew.${ENDCOLOR}"
brew cleanup

echo -e "${BOLDBLUE}Installing homebrew cask${ENDCOLOR}"
brew install homebrew/cask

echo -e "${BOLDBLUE}Copying dotfiles from Github${ENDCOLOR}"
cd ~/Code
git clone git@github.com:MarcTroesken/dotfiles.git

#Install Zsh & Oh My Zsh
echo -e "${BOLDBLUE}Installing Oh My ZSH...${ENDCOLOR}"
curl -L http://install.ohmyz.sh | sh

echo -e "${BOLDBLUE}Setting ZSH as shell...${ENDCOLOR}"
chsh -s /bin/zsh

echo -e "${BOLDBLUE}Copying nvm to .zshrc${ENDCOLOR}"
echo "#!/bin/sh
alias vim='nvim'
alias v='nvim'
alias gaa='git add .'
alias gc='git commit -m'
alias gp='git push'
alias dc='docker compose'
alias ll='ls -l'
" > ~/.aliases

echo "
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source ~/.aliases
" >> ~/.zshrc

echo -e "${BOLDBLUE}Install shell completion and highlightning${ENDCOLOR}"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i'' -e 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' /Users/mtroesken/.zshrc
sed -i'' -e 's/# export PATH=$HOME/bin:/usr/local/bin:$PATH/export PATH=$HOME/bin:/usr/local/bin:$PATH/g' /Users/mtroesken/.zshrc

# Apps
apps=(
  notion
  font-hack-nerd-font
  font-fira-code-nerd-font
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo -e "${BOLDBLUE}Installing apps with Cask...${ENDCOLOR}"
brew tap homebrew/cask-fonts
brew install --cask --appdir="/Applications" ${apps[@]}
brew cleanup

echo -e "${BOLDBLUE}Symlinking dotfiles ;) ${ENDCOLOR}"
mkdir ~/.config
ln -s ~/Code/dotfiles/alacritty ~/.config/alacritty
ln -s ~/Code/dotfiles/nvim ~/.config/nvim
ln -s ~/Code/dotfiles/tmux ~/.config/tmux

echo -e "${BOLDGREEN}Done!${ENDCOLOR}"
