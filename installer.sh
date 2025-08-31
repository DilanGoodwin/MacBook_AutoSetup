#!/bin/bash

declare -a Homebrew_Taps=("git" "tmux" "curl" "gdb" "cmake" "lua" "lua-language-server" "luarocks" "rust" "node" "openjdk" "python" "pyenv" "perl" "ripgrep" "screen" "tree-sitter" "readline" "zsh" "jdtls")
declare -a Homebrew_Cask=("firefox" "iterm2" "1password" "1password-cli" "font-blex-mono-nerd-font" "rectangle-pro" "slack")

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Logging
logger="$HOME/Documents/MacBook_AutoSetup_log.txt"
touch $logger

# Create File Structures
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.config/tmux
mkdir -p $HOME/.config/omz/plugins

mkdir -p $HOME/Documents/GitHub/neovim
mkdir -p $HOME/Documents/GitHub/MacBook_AutoSetup

# Install HomeBrew
printf "\n\nInstalling Homebrew"
NONINTERACTIVE=1 /bin/bash -c \
   "$(curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> $logger

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

for tap in "${Homebrew_Taps[@]}"
do
  printf "Brew Installing $tap"
  brew install $tap >> $logger
done

for cask in "${Homebrew_Cask[@]}"
do
  printf "Brew Installing $cask"
  brew install --cask $cask >> $logger
done

printf "Cleaning Installation Files from Brew"
brew cleanup >> $logger

# Clone Desired Repos
printf "\n\nCloning Git Repos for Configuration"

printf "MacBook_AutoSetup.git"
git clone https://github.com/DilanGoodwin/MacBook_AutoSetup.git $HOME/Documents/GitHub/MacBook_AutoSetup >> $logger

printf "neovim.git"
git clone https://github.com/neovim/neovim.git $HOME/Documents/GitHub/neovim >> $logger

printf "nvim.config.git"
git clone https://github.com/DilanGoodwin/nvim.config.git $HOME/.config/nvim >> $logger

printf "zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/omz/plugins/zsh-autosuggestions >> $logger

printf "zsh-syntax-highlighting.git"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.config/omz/plugins/zsh-syntax-highlighting >> $logger

# Tmux Configs
printf "\n\nCopying Tmux Config"
cp $HOME/Documents/GitHub/MacBook_AutoSetup/tmux.conf $HOME/.config/tmux/tmux.conf

# Install Nvim
printf "\n\nInstall Nvim"
cd $HOME/Documents/GitHub/neovim
git checkout stable >> $logger
make CMAKE_BUILD_TYPE=Release >> $logger
sudo make install >> $logger
:

# Install Oh-My-Zsh
printf "\n\nInstalling Oh-My-Zsh"
rm $HOME/.zshrc
cp $HOME/Documents/GitHub/MacBook_AutoSetup/.zshrc $HOME/.zshrc

sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended --keep-zshrc >> $logger
