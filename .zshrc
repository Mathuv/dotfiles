# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 2018-12-06
# export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/mediushealth/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# Mathu - Commented as per https://medium.com/@elviocavalcante/5-steps-to-improve-your-terminal-appearance-on-mac-osx-f58b20058c84
# 20180802 mathu: Disabled this after installing powerlevel theme
# ZSH_THEME="robbyrussell"
# ZSH_THEME="dracula"
# ZSH_THEME="agnoster"
# 20180802 Mathu
# nerdfont-complete has to be loaded before using powerlevel9k theme to show the special symbles
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git)
# Mathu modified
# zsh-syntax-highlighting should come before history-substring-search as per latter's documentation
# plugins=(git zsh-syntax-highlighting osx brew pyenv python pylint redis-cli pip virtualenvwrapper postgres pep8 aws celery colored-man-pages django docker docker-compose)
# Disabling vi-mode
# plugins=(git osx brew python django python colored-man-pages celery aws colorize pip docker docker-compose docker-machine zsh-syntax-highlighting history-substring-search virtualenv vi-mode tmux zsh-completions git-open)
# plugins=(git osx brew python django python colored-man-pages celery aws colorize pip docker docker-compose docker-machine zsh-syntax-highlighting history-substring-search virtualenv tmux zsh-completions git-open)
plugins=(git osx brew python fzf django colored-man-pages colorize pip zsh-syntax-highlighting zsh-completions git-open docker docker-compose docker-machine)

# 2018-08-27 Mathu: https://github.com/zsh-users/zsh-completions
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

# 2018-07-19 Mathu
# Add key bindings for history-substring-search

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
# 2018-10-30 After elixit installation via brew
# export MANPATH="/usr/local/opt/erlang/lib/erlang/man:$MANPATH"

# 20201214 Solution to tmux on Alacritty. Enable below.
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# 20201214 Solution to tmux on Alacritty.
export LC_CTYPE=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# Set neovim as default editor
# export VISUAL=nvim
# export EDITOR="$VISUAL"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# 2018-08-31 Mathu: Aliases
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias top="sudo htop" # alias top and fix high sierra bug
alias preview="fzf --preview 'bat --color \"always\" {}'"
# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
# to enable preview
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# to enable preview for Ctrl + R
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
alias ping='prettyping --nolegend'
alias cat='bat'
alias cl='clear'

# git aliases
# alias gst='git status'
alias gdn='git diff --name-only'
alias gdnp="gdn -- '*.py'"
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtr='git worktree remove'
alias gwtl='git worktree list'

alias prp="pipenv run python"

# 2018-01-24 After brew install thefuck
alias f="fuck"

# 20190204 Mathu TLDR
alias tldr="tldr -t base16"

alias ytmusic="mpsyt"

alias nvt="nvim -c terminal"
alias nv="nvim"

# https://github.com/gleitz/howdoi
alias hd='function hdi(){ printf "<>%.0s" {1..$COLUMNS}; printf "\n\n"; howdoi $* -c -n 5; }; hdi'
alias hda='function hdia(){ printf "<>%.0s" {1..$COLUMNS}; printf "\n\n"; howdoi $* -a -c -n 5; }; hdia'

# print terminal divider
alias pd="printf '>%.0s' {1..$COLUMNS}" 

# go-jira
alias jrb='jira browse'
alias jrc='jira create'
alias jre='jira edit'
alias jrst='jira subtask'

#google translation
alias td='trans de:'
alias tdp='trans de: -p'
alias te='trans :de'
alias tep='trans :de -p'
alias tdt='trans de:ta'
alias tet='trans :ta'
alias tte='trans ta:'
alias ttd='trans ta:de'

alias gi='grep -i'
alias al='alias'
alias algi='alias | grep -i'
alias pil='pip list'
alias pilgi='pip list | grep -i'
alias pif='pip freeze'
alias pifgi='pip freeze | grep -i'

alias t='tree'
alias 'git co'='git checkout'
alias grbod='git rebase -i origin/develop'
alias grubd='git recent-branches-date'
alias grub='git recent-branches'
alias grubdr='git recent-branches-date-remote'

alias pbc='pbcopy'
alias pbp='pbpaste'

alias act='source .venv/bin/activate'
alias dact='source deactivate'

alias drun='./manage.py runserver'
alias getbr="git fetch && git checkout '$1' && git pull"

alias lg='lazygit'
alias yd='ydiff -s -w0'

alias cfg='/usr/local/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
alias rgi='rg -i'
alias rgie='rgi -e'
alias rgiel='rgie -l'

alias pt='pytest'
alias ptd='pytest --pdb'
alias ptlf='pytest --lf'
alias ptlfd='pytest --pdb --lf'

alias xa='xargs'
alias xan='xargs nvim'

# https://gist.github.com/XVilka/8346728
function check-terminal-colours {
	awk 'BEGIN{
	    s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
	    for (colnum = 0; colnum<77; colnum++) {
		r = 255-(colnum*255/76);
		g = (colnum*510/76);
		b = (colnum*255/76);
		if (g>255) g = 510-g;
		printf "\033[48;2;%d;%d;%dm", r,g,b;
		printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
		printf "%s\033[0m", substr(s,colnum+1,1);
	    }
	    printf "\n";
    }'
}


# https://hackernoon.com/be-125-more-efficient-with-git-60556a1ce971
# alias git-show-interactive="git show $(git log --pretty=oneline | fzf | cut -d=' ' -f1)"


# 2018-11-26 fzf aliases
# fbr() {
#   git fetch
#   local branches branch
#   branches=$(git branch -a) &&
#   branch=$(echo "$branches" | fzf +s +m -e) &&
#   git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
# }

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# 2019-11-12 https://github.com/cheat/cheat/blob/master/scripts/fzf.bash
# This function enables you to choose a cheatsheet to view by selecting output
# from `cheat -l`. `source` it in your shell to enable it. (Consider renaming
# or aliasing it to something convenient.)

# Arguments passed to this function (like --color) will be passed to the second
# invokation of `cheat`.
# function cheat-fzf {
#   eval `cheat -l | tail -n +2 | fzf | awk -v vars="$*" '{ print "cheat " $1 " -t " $3, vars }'`
# }

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 1 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages $1 | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 $1 || rg --ignore-case --pretty --context 10 $1 {}"
}



# like normal autojump when used with arguments but displays an fzf prompt when used without
j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sed '/_____/Q; s/^[0-9,.:]*\s*//' |  fzf --height 40% --reverse --inline-info)" 
}

# Mathu
function get-branch() {
	git fetch
	git checkout "$1"
	git pull
}

# Mathu
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Below is commented out becuase now it's activate dunder 'plugins' above
# source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# 20180804 Mathu Pipenv auto completion
# eval "$(pipenv --completion)"

# 20191104 go-jira tab completion
# eval "$(jira --completion-script-zsh)"

# # 20180801 MATHU Zsh Themen configuration - START
# # https://medium.com/the-code-review/make-your-terminal-more-colourful-and-productive-with-iterm2-and-zsh-11b91607b98c
# This has got even more info abut installing
# https://github.com/bhilburn/powerlevel9k/wiki/Install-Instructions#step-1-install-powerlevel9k
# POWERLEVEL9K_MODE='nerdfont-complete'
# source  ~/powerlevel9k/powerlevel9k.zsh-theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs newline status)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
# POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
 DISABLE_UPDATE_PROMPT=true
# Mathu to show virtual env
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv vi_mode)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv time)
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# POWERLEVEL9K_VI_COMMAND_MODE_STRING="NORMAL"
# # END

# 20191027 Set vi-mode
# set -o vi


# 2018-10-02 Mathu: ZSH options
setopt hist_find_no_dups
# setopt hist_ignore_dups
setopt hist_ignore_all_dups

# 2018-11-24 after brew install autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# 2019-11-06 Disable Cowsay
# 2018-09-18 Mathu: Add Colourful Cows to yur terminal
# https://schier.co/blog/2016/08/09/add-colorful-cows-to-your-terminal/
# Randomly select a cow name
cow=$(node -e "var c='$(cowsay -l)'.split('  ');console.log(c[Math.floor(Math.random()*c.length)])")

# Or, if you have shuf (or gshuf) installed
#  cow=$(shuf -n 1 -e $(cowsay -l))

fortune | cowsay -f "$cow" | lolcat --spread 1.0

# https://remysharp.com/2018/08/23/cli-improved
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 20191120 https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/fzf
# export FZF_BASE="$HOME/.fzf"

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# Uncomment the following line to disable key bindings (CTRL-T, CTRL-R, ALT-C)
# export DISABLE_FZF_KEY_BINDINGS="true"


# 2018-10-02 Mathu: To not show duplicate result in ctrl+r fzf result
# https://github.com/junegunn/fzf/pull/1363
export FZF_UNIQUE_HISTORY=1

# 2018-10-08 https://github.com/rupa/z
# brew install z
. /usr/local/etc/profile.d/z.sh

# pyenv initi command should be at the end of the file
# Below are moved from .zprofile (originally from .zshenv)
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# 2018-09-19 Mathu: Re-enabled after finding out that 'pyenv virtualenv <name>' command
# no longer works
# 2018-09-17 Mathu: Disabled after uninstalling pyenv-virtualenv with brew
# Mathu - for pyenv virtual env (https://github.com/pyenv/pyenv-virtualenv)
# eval "$(pyenv virtualenv-init -)"
if which pyenv-virtualenv-init > /dev/null; then 
    eval "$(pyenv virtualenv-init -)"; 
fi

# 2018-01-23 After brew install thefuck
eval $(thefuck --alias)

# After brew install curl
export PATH="/usr/local/opt/curl/bin:$PATH"

# Use RipGrep for FZF search
# https://medium.com/@sidneyliebrand/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861
# include hidden
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
# exclude hidden
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs'
export FZF_DEFAULT_COMMAND='rg --files'
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
#
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF autocompletion
# https://github.com/junegunn/fzf/wiki/Examples-(completion)
_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all)
    if [[ $ARGS == 'git co'* ]]; then
        _fzf_complete "--reverse --multi" "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

# 20190703 After installing rust
export PATH="/Users/mediushealth/.cargo/bin:$PATH"

# 2019-05-06 after brew install nvm 9node version manager)
# export NVM_DIR=/Users/mediushealth/.nvm
#   [ -s /usr/local/opt/nvm/nvm.sh ] && . /usr/local/opt/nvm/nvm.sh  # This loads nvm
#   [ -s /usr/local/opt/nvm/etc/bash_completion ] && . /usr/local/opt/nvm/etc/bash_completion  # This loads nvm bash_completion

# # added by travis gem
# [ -f /Users/mediushealth/.travis/travis.sh ] && source /Users/mediushealth/.travis/travis.sh
export PATH="/usr/local/opt/openssl/bin:$PATH"
alias jrsp='jira sprint'
alias tm='tmux'
alias nvd='nvim $(gdn)'
alias bld='black $(gdn)'
alias isd='isort $(gdn)'
alias gcbr='git current-branch'

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/mediushealth/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mediushealth/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/mediushealth/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mediushealth/google-cloud-sdk/completion.zsh.inc'; fi

# Created by `userpath` on 2020-07-21 01:56:44
export PATH="$PATH:/Users/mediushealth/.local/bin"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

PATH="/Users/mediushealth/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/mediushealth/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/mediushealth/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/mediushealth/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/mediushealth/perl5"; export PERL_MM_OPT;

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/bit bit
