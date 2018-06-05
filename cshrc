#!/bin/csh -x


setenv GREP_COLOR '1;31'

bindkey -k up history-search-backward
bindkey -k down history-search-forward


# Set The Prompt 
if ($?prompt) then
    set prompt="%{^[[34;1m%}[%m%b]%{^[[30;0m%}%C2 >"
    #color statment is %{^[[34;1m%} 34=color 1m=light all between %{%}
endif



alias GIT_BRANCH_CMD "sh -c 'git branch --no-color 2> /dev/null' | sed -e '/^[^*]/d' -e 's/* \(.*\)/\(\1)/'"
#alias cd 'chdir \!*;set prompt="%{\033[32;40m%}"`whoami`@`hostname`": %{\033[33;40m%}%~%{\033[37;40m%}"`GIT_BRANCH_CMD`"%{\033[32;40m%} >%{\033[0m%} "; ls'
#alias cd 'chdir \!*;set prompt="%{^[[34;1m%}[%m%b]%{^[[30;0m%}%C2 `GIT_BRANCH_CMD`%{\033[32;40m%} >%{\033[0m%}>"'
#alias cd 'chdir \!*;set prompt="%{^[[34;1m%}[%m%b]%{^[[30;0m%}%C2 `GIT_BRANCH_CMD`>"; ls'

cd ~

alias __git_current_branch 'git rev-parse --abbrev-ref HEAD >& /dev/null && echo "[`git rev-parse --abbrev-ref HEAD`]"'
alias precmd 'set prompt="%{^[[34;1m%}[%m%b]%{^[[30;0m%}%C2`__git_current_branch`> "'
#alias precmd 'set prompt="%n@%m[%c2]`__git_current_branch` "'


if ( -r /ccase/stdcshrc ) then
  source /ccase/stdcshrc
endif

set OS = `uname -s`
## Include standard ClearCase settings
#setenv LD_LIBRARY_PATH $QTDIR/lib:/usr/local/lib
#setenv LD_LIBRARY_PATH /lib:/usr/bin
set autologout=0
set TMOUT=0

set path=($PATH /opt/BullseyeCoverage/bin /bin /usr/bin /usr/local/bin /usr/ucb /usr/local/lib /usr/openwin/bin /usr/sbin /sbin /etc/vx/bin /usr/lib/vxvm/bin /usr/ccs/bin /etc . /usr/local/share/ /usr/local/share/vim/vim61 /usr/local/ccm /usr/local/ccm/bin /usr/local/share/vim/vim61/syntax/ /usr/bin/X11 /opt/Rational/releases/purify.sol.2002a.06.00.Proto.0038/ /opt/gzip/bin/ /opt/tusc/bin/ ) 
#setenv MANPATH /opt/VRTS/man
setenv MANPATH /usr/man:/usr/local/man:/opt/VRTS/man:/usr/share/man:/opt/tusc/man
set autologout=0

#set filec
setenv LS_COLORS 'no=00:fi=00:di=01;96:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:*.cpp=01;35:*.h=02;36:*core=40;31;01'



#setenv MAILDIR Maildir
#setenv CXX colorgcc

#limit coredumpsize unlimited


#setenv CVSROOT ':pserver:shahar@10.1.1.248:/opt/cvsroot'

#xhost +





bindkey -k up history-search-backward
bindkey -k down history-search-forward

#setenv MANPATH /usr/man:/usr/local/man:/hpc/home/USERS/shahark/work/embedded_compiler/ch/ch/docs/man


#stty erase 
#stty intr 
source $HOME/.alias
