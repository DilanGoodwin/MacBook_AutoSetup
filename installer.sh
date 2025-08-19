#!/bin/bash

declare -a Homebrew_Taps=("git" "tmux" "curl" "gdb" "cmake" "lua" "rust" "node" "openjdk" "python" "pyenv" "perl" "ripgrep" "screen" "tree-sitter" "readline" "zsh")
declare -a Homebrew_Cask=("firefox" "iterm2" "1password" "1password-cli" "font-ubuntu-nerd-font" "rectangle-pro")

touch $HOME/Downloads/MacBook_AutoSetup_log.txt
log = $HOME/Downloads/MacBook_AutoSetup_log.txt

# Xcode
echo "Installing Xcode Tools"
sudo xcode-select --install >> $log 

# Install HomeBrew
echo "Installing Homebrew"
NONINTERACTIVE=1 /bin/bash -c \
   "$(curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" >> $log 

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# HomeBrew
for tap in "${Homebrew_Taps[@]}"
do
  echo "Brew Installing $tap"
  brew install $tap >> $log
done

for cask in "${Homebrew_Cask[@]}"
do
  echo "Brew Installing $cask"
  brew install --cask $cask >> $log
done

echo "Cleaning Installation Files from Brew"
brew cleanup

# Oh-My-Zsh & Tmux Configs
git clone https://github.com/DilanGoodwin/MacBook_AutoSetup.git >> $log

echo "Copying zsh Config"
rm $HOME/.zshrc
cp MacBook_AutoSetup/.zshrc $HOME/.zshrc

echo "Copying Tmux Config"
mkdir -p $HOME/.config/tmux
cp MacBook_AutoSetup/tmux.conf $HOME/.config/tmux/tmux.conf

rm -rf MacBook_AutoSetup

# Install Nvim
echo "Install Nvim"
mkdir -p $HOME/Documents/GitHub
git clone https://github.com/neovim/neovim.git $HOME/Documents/GitHub/neovim >> $log

cd $HOME/Documents/GitHub/neovim
git checkout stable >> $log
make CMAKE_BUILD_TYPE=Release >> $log
sudo make install >> $log 
:

echo "Adding Nvim Config"
mkdir -p $HOME/.config/nvim
git clone https://github.com/DilanGoodwin/nvim.config.git $HOME/.config/nvim >> $log

# Install Oh-My-Zsh
echo "Installing Oh-My-Zsh"
KEEP_ZSHRC='yes'
OVERWRITE_CONFIRMATION='no'

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended >> $log 
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
exit
