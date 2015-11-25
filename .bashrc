#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export HISTCONTROL=ignoreboth
GREENFG='\[\e[0;32m\]'
GREENFG2='\[\e[1;32m\]'
REDFG='\[\e[1;31m\]'
BLUEFG='\[\e[1;34m\]'
UNCOLORED='\[\e[m\]'
export WNHOME=/usr/share/wordnet

#source /etc/bash_completion.d/git
#source /usr/share/bash-completion/bash_completion
source /usr/share/git/completion/git-prompt.sh
source /usr/share/git/completion/git-completion.bash
#source /etc/bash_completion.d/git
export PROMPT_COMMAND='tput setaf 1; if [[ -z $i ]] ; then i=$(tput cols) ; while (( i-- > 12 )) ; do printf "\xe2\x94\x80" ; done ; echo -n " " ; date +%X ; unset i ; fi'
export PS1="$GREENFG\u@\h$REDFG\$(__git_ps1) $BLUEFG\w \n$GREENFG2↳ $UNCOLORED"

set -o vi

complete -cf sudo
complete -c man

export EDITOR=vim

#export PATH="/usr/lib/colorgcc/bin:$PATH:/home/blueblob/bin:/usr/totalview/bin:/opt/cxoffice/bin:$HOME/.cabal/bin"
export PATH="$HOME/bin:/usr/totalview/bin:/opt/cxoffice/bin:$HOME/.cabal/bin:$PATH:$HOME/MEGA/dissertation/src/bin:$HOME/MEGA/dissertation/src/scripts"

# sudo rename .txt .csv *.txt 
alias lock="i3lock -i $HOME/wallpapers/archlinuxBlack.png"
alias todo="/usr/bin/todo.sh -d $HOME/MEGA/todo/todo.cfg"
alias fixmouse='sudo modprobe -r psmouse && sudo modprobe -a psmouse && sudo modprobe -r ehci_hcd && sudo modprobe ehci_hcd'
alias grep='grep --color'
alias fgrep='fgrep --color'
alias gist='git status'
alias grep='grep --color'
alias la='ls -a --color=auto'
alias lab='ssh lab'
alias intuit='ssh intuit'
alias lap='ssh lap'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias m210='lpr -H thayercups -Pm210 -o fit-to-page -o "sides=two-sided-long-edge" -o "media=Letter"'
alias m210-color='lpr -H thayercups -Pm210-color -o fit-to-page -o "sides=two-sided-long-edge" -o "media=Letter"'
alias ols="ls -la --color | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"
alias gist='git status'
alias R='LD_LIBRARY_PATH=/opt/java/jre/lib/amd64/server /usr/bin/R'
alias Rscript='LD_LIBRARY_PATH=/opt/java/jre/lib/amd64/server /usr/bin/Rscript'
alias :q='exit'
alias tls='tmux list-sessions'
alias diff='colordiff'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

export MARKPATH=$HOME/.config/marks
function j { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}
complete -F _completemarks jump
complete -F _completemarks j
complete -F _completemarks unmark

# colorize man pages (Thanks Archlinux Wiki)
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
#JAVA_HOME=/opt/java/jre
JAVA_HOME=/usr/lib/jvm/java-8-jdk
alias 7='vboxmanage startvm Full7'
alias firefox='/usr/bin/firefox -new-instance -P default'
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache

gsay() { if [[ "${1}" =~ -[a-z]{2} ]]; then local lang=${1#-}; local text="${*#$1}"; else local lang=${LANG%_*}; local text="$*";fi; mplayer "http://translate.google.com/translate_tts?ie=UTF-8&tl=${lang}&q=${text}" &> /dev/null ; }


title () { 
    printf "\033]0;%s\007\n" "$@" 
}

synchronize () {
    if [[ -z $3 || ! $1 =~ ^-[tf]$ ]]; then
        echo "Missing arguments. Syntax: {-t|-f} HOST PATH [PATH ...]"
        return 1
    fi
    direction=$1
    host="$2:"
    sync='rsync -e ssh -al --progress'
    shift 2
    for item in "$@"; do
        title "$HOSTNAME: Transferring '$item' $direction $host..."
        item=$(readlink -f "$item")
        item=${item%/}
        target=$(dirname "$item")
        if [[ $direction == '-f' ]]; then
            $sync $host"$item" "$target"
        else
            $sync "$item" $host"$target"
        fi
    done
}
alias teach='synchronize -t'
alias learn='synchronize -f'

f () {
    q=$1
    shift
    if [ "$#" = "0" ]; then
        set "."
    fi
    for dir in "$@"; do
        find "$dir" -iname "*$q*"
        shift
    done
}

c () {
    ls='ls -A -sh --color=auto'
    if [[ $1 ]]; then
        if [[ $1 == '-q' ]]; then
            ls='true'
            shift
        fi
        for dir in "$@"; do
            if [[ -d $dir ]]; then
                command cd "$dir"
            else
                command cd *"${dir}"*
            fi
        done
    else
        command cd ~
    fi
    $ls
}

# Entering a directory name as a bare word will change into that directory
shopt -s autocd
# Automatically correct off-by-one typing mistakes when changing directories
shopt -s cdspell
# Make Bash wrap text properly if the terminal size changes
shopt -s checkwinsize
# Store multi-line commands in shell history as one-liners for easy editing
shopt -s cmdhist
# Correct off-by-one typing mistakes when tab-completing directories
shopt -s dirspell
# Allow aliases to be expanded even in non-interactive sessions
shopt -s expand_aliases
# Enable fancy globbing functions
shopt -s extglob
# Enable the recursive glob (**) function
shopt -s globstar
# Don't clobber other sessions' changes to global history when exiting
shopt -s histappend
# Don't try to complete on empty lines
shopt -s no_empty_cmd_completion

c(){ cd ${1:1};}
alias changeicon='xseticon -id $(xdotool getactivewindow) /usr/share/icons/Faenza/apps/96/xterm.png'
[[ "$TERM" == "rxvt-256color" ]] && changeicon

#Alias g to git and get completion for it
alias g=git
complete -o bashdefault -o default -o nospace -F _git g 2>/dev/null \ || complete -o default -o nospace -F _git g

# Since Arch stupidly decided that the default package shouldn't have icons
# for urxvt, set the icon if we are in urxvt
[[ $TERM == "rxvt-256color" ]] && changeicon
tmux () {
    xseticon -id $(xdotool getactivewindow) /usr/share/icons/Faenza/apps/96/terminator.png
    /usr/bin/tmux $@
    xseticon -id $(xdotool getactivewindow) /usr/share/icons/Faenza/apps/96/xterm.png
}

alias skype='env PULSE_LATENCY_MSEC=30 /usr/bin/skype'
alias showRecipes='zathura ~/recipes/4810.pdf &'
alias findDups='find -not -empty -type f -printf "%s\n" | sort -rn | uniq -d | xargs -I{} -n1 find -type f -size {}c -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate'
alias l='ls --color=auto'


CLASSPATH="$CLASSPATH:/storedisk/BART/dist/BART.jar"
for i in /storedisk/BART/libs/*.jar; do
	CLASSPATH="$CLASSPATH:$i"
done
export CLASSPATH
alias pb='if tmux list-sessions|grep piano;then tmux attach -t piano; else tmux new -s piano -d \; new-window 'pianobar' \; kill-window -t0 \; attach;fi'

q() {
    $@ &>/dev/null &
}

alias led='vim --servername VIM `ls *.latexmain|sed 's/\.latexmain$//g'` ../bib.bib'
alias gcalcli='/usr/bin/gcalcli --noauth_local_webserver'
alias zim="/usr/bin/zim ~/MEGA/Notes/notebook.zim"
alias vim='/usr/bin/vim 2>/dev/null'
