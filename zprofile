source /opt/boxen/env.sh

# Rust config
export PATH="$HOME/dotfiles/bin:$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.fastlane/bin:$PATH"

# Add colors to ls
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Define prompt theme directory
fpath=( "$HOME/.zfunctions" $fpath )
