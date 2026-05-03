export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Force pre-commit/virtualenv to use pyenv's python3.11 instead of
# homebrew's newer python3.14 (old black/flake8 pins break on >=3.12).
export VIRTUALENV_PYTHON=python3.11

# NVM (homebrew) path
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Bun path
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Python alias
alias pip="pip3"

# dotnet path
export PATH="$PATH:$HOME/.dotnet"
export DOTNET_ROOT="$HOME/.dotnet"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# Starship prompt
command -v starship >/dev/null && eval "$(starship init zsh)"
