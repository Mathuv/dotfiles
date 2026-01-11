
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mathu/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/mathu/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/mathu/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/mathu/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


[ -s "/Users/mathu/.scm_breeze/scm_breeze.sh" ] && source "/Users/mathu/.scm_breeze/scm_breeze.sh"
. "$HOME/.cargo/env"

. "$HOME/.atuin/bin/env"
