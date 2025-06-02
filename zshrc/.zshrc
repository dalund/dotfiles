export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
  
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/e2fsprogs/bin:$PATH"
export PATH="/opt/homebrew/opt/e2fsprogs/sbin:$PATH"
export PATH="~/dev/qemu/build:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export HOMEBREW_GITHUB_API_TOKEN=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
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/zig-macos-aarch64-0.14.0-dev.2627+6a21d18ad
alias gits='git status'
alias gitl='git log'
source "$HOME/.rye/env"

. "$HOME/.local/bin/env"
