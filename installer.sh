#!/bin/bash

Homebrew_Taps=("git" "tmux" "curl" "gdb" "cmake" "lua" "openjdk" "python" "pyenv" "perl" "qmk-toolbox" "ripgrep" "screen" "tree-sitter" "readline" "zsh")
Homebrew_Cask=("firefox" "iterm2" "1password" "1password-cli" "font-ubuntu-nerd-font" "rectangle")

# Xcode
sudo xcode-select --install

# Install HomeBrew
NONINTERACTIVE=1 /bin/bash -c \
   "$(curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# HomeBrew
for tap in Homebrew_Taps
do
  echo "Brew Installing $tap"
  brew install $tap
done

for cask in Homebrew_Cask
do
  echo "Brew Installing $cask"
  brew install --cask $cask 
done

# Oh-My-Zsh & Tmux
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

git clone https://github.com/DilanGoodwin/MacBook_AutoSetup.git
rm $HOME/.zshrc
cp MacBook_AutoSetup/.zshrc $HOME/.zshrc

mkdir -p $HOME/.config/tmux
cp MacBook_AutoSetup/tmux.conf $HOME/.config/tmux/tmux.conf

# Install Nvim

# Configure Nvim 

