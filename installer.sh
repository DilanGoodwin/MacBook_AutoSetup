#!/bin/bash

declare -a Homebrew_Taps=("git" "tmux" "curl" "gdb" "cmake" "lua" "openjdk" "python" "pyenv" "perl" "qmk-toolbox" "ripgrep" "screen" "tree-sitter" "readline" "zsh")
declare -a Homebrew_Cask=("firefox" "iterm2" "1password" "1password-cli" "font-ubuntu-nerd-font" "rectangle")

touch MacBook_AutoSetup_log.txt

# Xcode
echo "Installing Xcode Tools"
sudo xcode-select --install >> MacBook_AutoSetup_log.txt

# Install HomeBrew
echo "Installing Homebrew"
NONINTERACTIVE=1 /bin/bash -c \
   "$(curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> MacBook_AutoSetup_log.txt

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# HomeBrew
for tap in "${Homebrew_Taps[@]}"
do
  echo "Brew Installing $tap"
  brew install $tap >> MacBook_AutoSetup_log.txt
done

for cask in "${Homebrew_Cask[@]}"
do
  echo "Brew Installing $cask"
  brew install --cask $cask >> MacBook_AutoSetup_log.txt
done

brew cleanup

# Oh-My-Zsh & Tmux
echo "Installing Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended >> MacBook_AutoSetup_log.txt
git clone https://github.com/DilanGoodwin/MacBook_AutoSetup.git

echo "Copying zsh Config"
rm $HOME/.zshrc
cp MacBook_AutoSetup/.zshrc $HOME/.zshrc

echo "Copying Tmux Config"
mkdir -p $HOME/.config/tmux
cp MacBook_AutoSetup/tmux.conf $HOME/.config/tmux/tmux.conf

# Install Nvim

# Configure Nvim 

