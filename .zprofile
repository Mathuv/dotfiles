# Set PATH, MANPATH, etc., for Homebrew.

# 2022-12-06
# https://blog.heim.xyz/m1-macs-having-two-shells-for-x86-and-arm/
# (-/+) Dynamically load plaform specific homebrew.
# eval "$(/opt/homebrew/bin/brew shellenv)"

if [[ "$(arch)" = "arm64" ]]; then
    echo "Detected ARM ..."
    export PATH="/opt/homebrew/bin:$PATH"
elif [[ "$(arch)" = "i386" ]]; then
    echo "Detected x86 ..."
    export PATH="/usr/local/Homebrew/bin:$PATH"
else
    echo "Unknown architecture."
fi

eval $(brew shellenv)

# Pyenv config - 2022-11-30
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Created by `pipx` on 2022-12-06 11:53:31
export PATH="$PATH:/Users/mathu/.local/bin"


# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

