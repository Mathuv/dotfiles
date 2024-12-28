# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting colored-man-pages kubectl kubetail)

# https://docs.brew.sh/Shell-Completion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/alias.sh

# Pyenv config - 2022-11-30
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; 
    then eval "$(pyenv virtualenv-init -)"; 
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `pipx` on 2022-12-06 11:53:31
export PATH="$PATH:/Users/mathu/.local/bin"

# If set, do not automatically update before running some commands e.g. brew install, brew upgrade and brew tap
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# fnm
export PATH="/Users/mathu/Library/Application Support/fnm:$PATH"
eval "`fnm env`"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# User neovim-remote to prevent nested nvim inside :terminal
# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then # deprecated in latest neovim
if [ -n "$NVIM" ]; then
    if [ -x "$(command -v nvr)" ]; then
      # alias nvim=nvr
      # open file in the other split
      alias nvim='nvr -l'
    else
      alias nvim='echo "No nesting!"'
    fi
fi

# preferred editor for local and remote sessions
export VISUAL=nvim
export EDITOR=nvim

# https://github.com/chubin/cheat.sh#usage
fpath=(~/.zsh.d/ $fpath)

# https://github.com/chubin/cheat.sh/issues/266
autoload -U compinit
compinit

# after installing languagetool: https://jdhao.github.io/2020/09/20/nvim_grammar_check_languagetool/
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export OPENSSL_ROOT_DIR=/opt/homebrew/opt/openssl@3

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/mathu/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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

# Aftre pipenv alerted
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"


# Load Angular CLI autocompletion.
source <(ng completion script)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mathu/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mathu/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mathu/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mathu/google-cloud-sdk/completion.zsh.inc'; fi

# scm_breeze. added by the installer
[ -s "/Users/mathu/.scm_breeze/scm_breeze.sh" ] && source "/Users/mathu/.scm_breeze/scm_breeze.sh"

alias config='/opt/homebrew/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export BAT_THEME=TwoDark

# add support for ctrl+o to open selected file in VS Code
# export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
# to enable preview
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# to enable preview for Ctrl + R
# export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

export FZF_COMPLETION_OPTS='--border --info=inline'

# CTRL-/ to toggle small preview window to see the full command
# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

  # Print tree structure in the preview window
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
export MANPAGER='nvim +Man!'

# alisases
load_env() {
    set -a
    source "$1"
    set +a
    echo "Uses $DJANGO_SETTINGS_MODULE"
}

# set BROWSER to open in chrome
export BROWSER="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

# To resovle postgres@14 not starting
# export LDFLAGS="-L/opt/homebrew/opt/icu4c@72/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/icu4c@72/include"
# export PATH="/opt/homebrew/opt/icu4c@72/bin:$PATH"
# export PATH="/opt/homebrew/opt/icu4c@72/sbin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="-I/opt/homebrew/opt/icu4c/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/icu4c/lib/pkgconfig"

eval "$(gh copilot alias -- zsh)"

export PATH="/Users/mathu/my_scripts:$PATH"

# Added by Windsurf
export PATH="/Users/mathu/.codeium/windsurf/bin:$PATH"
