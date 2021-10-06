# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/mathu/.oh-my-zsh"


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# 20210526 Removed for powerlevel10k
# ZSH_THEME="robbyrussell"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
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
# plugins=(git)
# From Med
# plugins=(git osx brew python fzf django colored-man-pages colorize pip zsh-syntax-highlighting zsh-completions git-open docker docker-compose docker-machine)
plugins=(git osx brew python fzf colored-man-pages colorize pip docker docker-compose docker-machine)


# 20210525 You may want to review this, disabling permission check
ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# User configuration

# auto suggestion
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

export PATH=/opt/homebrew/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# https://github.com/pyenv/pyenv/issues/1768
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

eval "$(pyenv init -)"

export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

if which pyenv-virtualenv-init > /dev/null; then 
  eval "$(pyenv virtualenv-init -)"; 
fi


# after installing nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Messes with emancs key binding
# bindkey -v ; export KEYTIMEOUT=1



# Created by `pipx` on 2021-05-25 13:24:50
export PATH="$PATH:/Users/mathu/.local/bin"

# If set, do not automatically update before running some commands e.g. brew install, brew upgrade and brew tap
export HOMEBREW_NO_AUTO_UPDATE=1


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

# After brew install postgres@9.6
export PATH="/opt/homebrew/opt/postgresql@9.6/bin:$PATH"

# export LDFLAGS="-L/opt/homebrew/opt/postgresql@9.6/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/postgresql@9.6/include"

# export PKG_CONFIG_PATH="/opt/homebrew/opt/postgresql@9.6/lib/pkgconfig"
 
# Brew openssl
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"

# export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"

# export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
# to enable preview
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# to enable preview for Ctrl + R
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
eval "$(thefuck --alias)"

# Some pgcli users like to disable line wrapping.
export LESS="-SRXF"

# Cargo
export PATH="/Users/mathu/.cargo/bin:$PATH"


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

export FZF_BASE=/opt/homebrew/bin/

# 20211025 This overrides fzf based ctrl+r handling.
# Removign this enable back fzf based one.
eval "$(mcfly init zsh)"
export MCFLY_FUZZY=true
export MCFLY_RESULTS=50
export MCFLY_INTERFACE_VIEW=BOTTOM

# Zoxide instead of z or autojump
eval "$(zoxide init zsh)"

# broot
source /Users/mathu/.config/broot/launcher/bash/br

# scm_breez
[ -s "/Users/mathu/.scm_breeze/scm_breeze.sh" ] && source "/Users/mathu/.scm_breeze/scm_breeze.sh"

# Manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Enable multiprocessing
# https://stackoverflow.com/questions/50168647/multiprocessing-causes-python-to-crash-and-gives-an-error-may-have-been-in-progr
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# User neovim-remote to prevent nested nvim inside :terminal
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim=nvr
  else
    alias nvim='echo "No nesting!"'
  fi
fi

export VISUAL=nvim
