#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
eval $(keychain --eval --agents ssh -Q --quiet ~/.ssh/id_rsa)
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
