#!/bin/bash

declare -a Homebrew_Taps=("git" "tmux" "curl" "gdb" "cmake" "lua" "lua-language-server" "luarocks" "rust" "node" "openjdk" "python" "pyenv" "perl" "ripgrep" "screen" "tree-sitter" "readline" "zsh" "jdtls")
declare -a Homebrew_Cask=("firefox" "iterm2" "1password" "1password-cli" "font-ubuntu-nerd-font" "rectangle-pro" "slack")

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

# Xcode
echo "Installing Xcode Tools"
xcode-select --install >> $logger 

# Install HomeBrew
echo "Installing Homebrew"
NONINTERACTIVE=1 /bin/bash -c \
   "$(curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> $logger

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

for tap in "${Homebrew_Taps[@]}"
do
  echo "Brew Installing $tap"
  brew install $tap >> $logger
done

for cask in "${Homebrew_Cask[@]}"
do
  echo "Brew Installing $cask"
  brew install --cask $cask >> $logger
done

echo "Cleaning Installation Files from Brew"
brew cleanup >> $logger

# Tmux Configs
echo "Copying Tmux Config"
cp $HOME/Documents/GitHub/MacBook_AutoSetup/tmux.conf $HOME/.config/tmux/tmux.conf

# Install Nvim
echo "Install Nvim"
git clone https://github.com/neovim/neovim.git $HOME/Documents/GitHub/neovim >> $logger

git checkout stable >> $logger
make CMAKE_BUILD_TYPE=Release >> $logger
sudo make install >> $logger
:

echo "Adding Nvim Config"
git clone https://github.com/DilanGoodwin/nvim.config.git $HOME/.config/nvim >> $logger

# Configure MacOS Settings
chmod +x $HOME/Documents/GitHub/MacBook_AutoSetup/SettingsConfigure.sh >> $logger
sh $HOME/Documents/GitHub/MacBook_AutoSetup/SettingsConfigure.sh >> $logger

# Install Oh-My-Zsh
echo "Installing Oh-My-Zsh"
rm $HOME/.zshrc
cp $HOME/Documents/GitHub/MacBook_AutoSetup/.zshrc $HOME/.zshrc

git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.config/omz/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.config/omz/plugins/zsh-syntax-highlighting

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended --keep-zshrc >> $logger

sudo reboot
