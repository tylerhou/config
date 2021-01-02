# Rust config
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="$HOME/.dotfiles/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Brew
export PATH="/usr/local/sbin:$PATH"

# Stack
export PATH="$HOME/.local/bin:$PATH"

# Define prompt theme directory
fpath=( "$HOME/.zfunctions" $fpath )

# Fix pyenv.
# For compilers to find zlib you may need to set:
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/zlib/lib"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/zlib/include"

# For pkg-config to find zlib you may need to set:
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH} /usr/local/opt/zlib/lib/pkgconfig"
