[ -f ~/.fzf.bash ] && source ~/.fzf.bash


export PATH="$PATH:/Users/mathu/.local/bin"

# Set up Python environment variables
export PIPENV_VENV_IN_PROJECT=1

. "$HOME/.cargo/env"


. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
