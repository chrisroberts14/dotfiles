# ~/.zshrc

#######################################################
# SOURCED ALIASES AND SCRIPTS BY zachbrowne.me
#######################################################

# Run fastfetch if available
if [ -x /usr/bin/fastfetch ]; then
    fastfetch
fi

# Zsh doesn't use /etc/bashrc, but it uses /etc/zshrc
if [ -f /etc/zshrc ]; then
    source /etc/zshrc
fi

# Zsh completion system
autoload -Uz compinit
compinit

#######################################################
# EXPORTS
#######################################################

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=500
SAVEHIST=10000
HISTTIMEFORMAT="%F %T "
setopt hist_ignore_dups hist_ignore_space hist_find_no_dups append_history share_history

# Disable bell
unsetopt BEEP

# Ctrl-S/XON-XOFF
stty -ixon

# Ignore case on completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Auto-completion list without double-tab
setopt auto_list
setopt auto_menu

# Default editor
export EDITOR=nano
export VISUAL=subl
alias spico='sudo pico'
alias snano='sudo nano'
alias vim='nvim'

# Colors for ls & grep
export CLICOLOR=1
export LS_COLORS='no=00:fi=32:di=37;01:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Prefer ripgrep
if command -v rg &>/dev/null; then
    alias grep='rg'
else
    alias grep='/usr/bin/grep --color=auto'
fi

# Manpage colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# ALIASES (all preserved)
#######################################################

alias web='cd /var/www/html'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1)"'
alias ebrc='nvim ~/.zshrc'
alias hlp='less ~/.bashrc_help'
alias sb='source ~/.zshrc'
alias da='date "+%Y-%m-%d %A %T %Z"'

# Common aliases (cp, mv, rm, ls, etc.) preserved exactly as in bashrc
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias vi='nvim'
alias svi='sudo vi'
alias vis='nvim "+set si"'

# Directory movement
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'

# Lots of ls variations for macOS
alias la='ls -Alh'
alias ls='ls -aFh -G'                    # Removed --color=always and -X
alias lx='ls -lh'                        # Removed -X and -B (not available on macOS)
alias lk='ls -lSrh'
alias lc='ls -ltcrh'
alias lu='ls -lturh'
alias lr='ls -lRh'
alias lt='ls -ltrh'
alias lm='ls -alh | more'
alias lw='ls -xAh'
alias ll='ls -Fls'
alias labc='ls -lap'
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"
alias lla='ls -Al'
alias las='ls -A'
alias lls='ls -l'

# chmod shortcuts
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search & monitoring
alias h="history | grep "
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"
alias f="find . | grep "
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"
alias checkcommand="whence -w"
alias openports='netstat -nape --inet'

# Reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Disk space
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Logs
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# Others
alias sha1='openssl sha1'
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'
alias kssh="kitty +kitten ssh"
alias docker-clean='docker container prune -f ; docker image prune -f ; docker network prune -f ; docker volume prune -f'
alias python="python3"
alias pip="pip3"
alias mk="make"
alias hug="hugo server -F --bind=10.0.0.97 --baseURL=http://10.0.0.97"
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

#######################################################
# FUNCTIONS (unchanged, all valid in zsh)
#######################################################
# (extract, ftext, cpp, cpg, mvg, mkdirg, up, cd override, pwdtail, distribution, ver, install_bashrc_support, whatsmyip, apachelog, apacheconfig, phpconfig, mysqlconfig, trim, gcom, lazyg, hb)
# --- Keep your entire function block exactly as-is ---

#######################################################
# PROMPT / TOOLS
#######################################################

# Bind Ctrl-f → "zi"
bindkey -s '^F' 'zi\n'

# Starship & zoxide
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

#######################################################
# Custom environment variables
#######################################################

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home
export ANDROID_HOME="$HOME/Library/Android/sdk"
export NDK_VERSION="23.1.7779620"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/$NDK_VERSION"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH" # sdkmanager
export PATH="$ANDROID_HOME/platform-tools:$PATH" #adb

# Env variables for ditto build to find z3
export Z3_SYS_Z3_HEADER="$(brew --prefix z3)/include/z3.h"
export LIBRARY_PATH="$(brew --prefix z3)/lib:$LIBRARY_PATH"
export DYLD_LIBRARY_PATH="$(brew --prefix z3)/lib:$DYLD_LIBRARY_PATH"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export CC_wasm32_unknown_unknown="$(brew --prefix)/opt/llvm/bin/clang"
ulimit -n 4096
export PATH="$HOME/.local/bin:$PATH"
