# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gruvbox-dark"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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
plugins=(
         git
         docker
         docker-compose
         colored-man-pages
         history-substring-search
         zsh-autosuggestions
         zsh-syntax-highlighting
         fasd
         fzf
         pass
         )

source $ZSH/oh-my-zsh.sh

# Fasd usage example
# alias a='fasd -a'        # any
# alias s='fasd -si'       # show / search / select
# alias d='fasd -d'        # directory
# alias f='fasd -f'        # file
# alias sd='fasd -sid'     # interactive directory selection
# alias sf='fasd -sif'     # interactive file selection
# alias z='fasd_cd -d'     # cd, same functionality as j in autojump
# alias zz='fasd_cd -d -i' # cd with interactive selection
# alias v='f -e "$EDITOR"'
# alias o='a -e xdg-open'
# alias j='zz'

# FZF Customization and Usage

# wild - fuzzy-match , 'wild - exact-match(quoted)
# CTRL-T - Paste the selected files and directories onto the command-line
# CTRL-R - Paste the selected command from history onto the command-line
# ALT-C  - cd into the selected directory

# Fuzzy completion for files and directories:
# Files under the current directory,you can select multiple items with TAB key - vim **<TAB>
# Files under parent directory                                                 - vim ../**<TAB>
# Files under parent directory that match `fzf`                                - vim ../fzf**<TAB>
# Files under your home directory                                              - vim ~/**<TAB>
# Directories under current directory (single-selection)                       - cd **<TAB>
# Directories under ~/github that match `fzf`                                  - cd ~/github/fzf**<TAB>

# Fuzzy completion for kill process IDs
# Can select multiple processes with <TAB> or <Shift-TAB> keys                 - kill -9 <TAB>

# Fuzzy completion for host names
# For ssh and telnet commands, fuzzy completion for hostnames is provided.
# The names are extracted from /etc/hosts and ~/.ssh/config.                   - ssh **<TAB>
#                                                                              - telnet **<TAB>

# Fuzzy completion for enviroment variables/aliases                            - unset **<TAB>
#                                                                              - export **<TAB>
#                                                                              - unalias **<TAB>

export FZF_DEFAULT_OPTS="--height 40% --inline-info --border"
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --exclude .git'

export FZF_CTRL_T_COMMAND='fdfind --type f --hidden --exclude .git'
export FZF_ALT_C_COMMAND='fdfind --type d --hidden --exclude .git'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

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

# usage of vimdiff:     vimdiff file1 file2 file3
#                       ]c [c jump between changes
#                       do(:diffget)    :%diffget apply to whole file
#                       dp(:diffput)    :%diffput apply to whole file
#                       :diffput(:diffget) file
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"
alias ll='ls -l'
alias la='ls -a'
alias bat='batcat'
alias fd='fdfind'
alias fzf='fzf -m'

# atool usage subsitute of tar/unzip/unrar
# aunpack (to extract archives)
# apack (to create archives)
# als (to list files in archives)
# acat (to extract files to standard out)

# trash-cli usage
# trash-put (trash files and directories)
# trash-empty (empty the trashcan)
# trash-list (list trashed file)
# trash-restore (restore a trashed file)
# trash-rm (remove individual files from the transhcan)

### Proxy Settings ###
function proxy_on() {
    export no_proxy="localhost,127.0.0.1,::1"

    if (( $# > 0 )); then
        valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\?\)\{4\}:\([0-9]\+\)/&/p')
        if [[ $valid != $@ ]]; then
            >&2 echo "Invalid address"
            return 1
        fi
        local proxy=$1
        export http_proxy="$proxy" \
               https_proxy=$proxy \
               ftp_proxy=$proxy \
               rsync_proxy=$proxy
        echo "Proxy environment variable set."
        return 0
    fi

    echo -n "username: "; read username
    if [[ $username != "" ]]; then
        echo -n "password: "
        read -es password
        local pre="$username:$password@"
    fi

    echo -n "server: "; read server
    echo -n "port: "; read port
    local proxy=$pre$server:$port
    export http_proxy="$proxy" \
           https_proxy=$proxy \
           ftp_proxy=$proxy \
           rsync_proxy=$proxy \
           HTTP_PROXY=$proxy \
           HTTPS_PROXY=$proxy \
           FTP_PROXY=$proxy \
           RSYNC_PROXY=$proxy
}
function proxy_off(){
    unset http_proxy https_proxy ftp_proxy rsync_proxy \
          HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY
    echo -e "Proxy environment variable removed."
}

#clash_dashboard
function clash_dash() {
    google-chrome "127.0.0.1:9090/ui"
}

# Git proxy setting
function proxy_on_git(){
  if (( $# > 0 )); then
      valid=$(echo $@ | sed -n 's/\([0-9]\{1,3\}.\?\)\{4\}:\([0-9]\+\)/&/p')
      if [[ $valid != $@ ]]; then
          >&2 echo "Invalid address"
          return 1
      fi
      export git_proxy='socks5://'$1
      git config --global http.proxy $git_proxy
      git config --global https.proxy $git_proxy
      echo "Git proxy settings added."
  else
    echo "Usage: one argument needed, passing in the proxy server address"
  fi
}
function proxy_off_git(){
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  unset git_proxy
  echo -e "Git proxy settings removed"
}

# Adding alacritty zsh completions to $fpath
fpath+=${ZDOTDIR:-~}/.zsh_functions

# Created by `pipx` on
export PATH="$PATH:/home/zibbo/.local/bin"
