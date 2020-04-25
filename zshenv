# Rust config
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"

# Setup pyenv on new shells
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"
eval "$(nodenv init -)"

# Define prompt theme directory
fpath=( "$HOME/.zfunctions" $fpath )
