
# Install HomeBrew
NONINTERACTIVE=1 /bin/bash -c \
   "$(curl -fsSL \
      https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# HomeBrew Taps
brew install git tmux curl gdb cmake lua openjdk python pyenv perl qmk-toolbox ripgrep screen tree-sitter readline

# HomeBrew Casks
brew install --cask firefox iterm2 1password font-ubuntu-nerd-font 1password-cli rectangle

# Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Install Nvim

# Configure Nvim 

