
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. /opt/homebrew/etc/profile.d/z.sh
eval "$(thefuck --alias)"

complete -C /opt/homebrew/bin/terraform terraform

eval "$(mcfly init bash)"

source /Users/mathu/.config/broot/launcher/bash/br

[ -s "/Users/mathu/.scm_breeze/scm_breeze.sh" ] && source "/Users/mathu/.scm_breeze/scm_breeze.sh"
