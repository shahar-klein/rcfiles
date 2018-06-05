#
# bashrc
# Roi Dayan (roid@mellanox.com)
#

source ~/.alias.bash

alias objdump='objdump -SdCgl'
alias cscope='cscope -Rqd'
alias python='/auto/app/Python-2.7.5/bin/python'
LC_ALL=en_US.UTF-8

### ESX WB ###
# coding style for eclipse: /vmgwork/DEV/vmdev_net/ddk-native/coding_style/native_esx_coding_style.xml
# /.autodirect/vmgwork/DEV/vmdev_net//ddks//inbox-6.0-native/coding_style
#alias objdump_esxi='/build/toolchain/lin32/gcc-4.1.2-9/x86_64-linux/bin/objdump -SdCgl'
#alias gcc_esxi='/build/toolchain/lin32/gcc-4.1.2-9/bin/x86_64-linux-gcc'
#alias cscope_esx51='cd /opt/vmware/vide/eclipse/opt/vmware/rosa_5.1_u1/src && cscope -Rqd && cd -'
#export MANPATH=/opt/vmware/ddk-5.5.0-1198610/docs/man/
#export PERL5LIB=/usr/lib/perl5/vendor_perl/5.10.0/

export CSCOPE_EDITOR=vim

alias checkpatch_esx='/.autodirect/vmgwork/GIT/scripts_esx.git/chkpatch/checkpatch.pl'
if [ -d /opt/vmware ]; then
    export MANPATH="$MANPATH:/opt/vmware/cimpdk-6.1.0-3575292/docs/man"
    alias cscope_esx55='cd /opt/vmware/vide/eclipse/opt/vmware/rosa_5.5_rc/src && cscope -Rqd && cd -'
fi

### END ESX WB ###

#mtlreg 10.0.20.54
#python /mswg/projects/test_suite2/bin/personal_report.py TEMPORARY roid
#/tmp/personal_email/ roid.html

index-path-kernel ()
{
    rm -i -f cscope.*;
    rm -i -f tags;
    for path in drivers/infiniband drivers/net/ethernet/mellanox drivers/net/vxlan.c net lib kernel arch/ia64/ arch/x86_64/ include/asm-generic/ include/net include/rdma include/linux include/uapi/linux include/uapi/rdma include/uapi/scsi include/uapi/asm-generic;
    do
        echo "index $path";
        find $path -name '*.[ch]' -o -name '*.cpp' | egrep --color=auto -v '#|~|cscope' >> cscope.files;
    done;
    echo "tags";
    cat cscope.files | xargs ctags -a;
    echo "cscope";
    /usr/bin/cscope -b -q -k -i cscope.files
}


# rsyslog : /.autodirect/r/syslog/2013/02/17/storm5

if [ -f /etc/profile ]; then . /etc/profile ; fi
if [ -f /etc/bashrc ]; then . /etc/bashrc ; fi

HISTTIMEFORMAT="%d/%m/%y %T "

# Append to history
shopt -s histappend

# History session size
export HISTSIZE=9999
# History file size
export HISTFILESIZE=999999

export PATH=$PATH:/usr/local/bin:~/bin:~roid/bin:~roid/scripts
export EDITOR=vim

#for i in `find -type d $HOME/scripts` ; do
#    export PATH=$PATH:$i
#done

source ~roid/.bash_completion

# search history
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff -uP'
alias ipmi='ipmitool.sh'

weather() {
    local city=${1:-Tel-aviv}
    curl --raw http://wttr.in/$city
}

vimgrep() {
    grep -rIn --color=always $* | sed -r 's@^([^:]+):([^:]+):@\1 +\2 : @'
}
alias vgrep='vimgrep'

export SW='/.autodirect/mtrswgwork/roid'
export SWVSA='/project/sw/storage/vsa'
export DCS='/project/sw/dcs'
test -d /.autodirect/mtrsysgwork/roid && export SWS='/.autodirect/mtrsysgwork/roid' || export SWS='/mtrsysgwork/roid'

alias sw='cd $SW'
alias swvsa='cd $SWVSA'
alias dcs='cd $DCS'
alias sws='cd $SWS'

alias eclipse='/auto/app/eclipse.mars/eclipse/eclipse'

alias perf_record='perf record -a -g'
alias perf_report='perf report'
alias perf_annotate='perf annotate'
alias test_suite2_regup='/mswg/projects/test_suite2/bin/regup.py'

#ref: http://hocuspokus.net/2009/07/add-git-and-svn-branch-to-bash-prompt/

parse_git_branch() {
  local b=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  __branch=$b
  if [ -n "$b" ]; then
      echo "(git::$b)"
      #echo "(git::$b$(git_modified)$(git_commit_not_pushed))"
      #echo "(git::$b$(git_modified))"
  fi
  unset __branch
}

parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print "(svn::"$1")" }'
}
parse_svn_url() {
    svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
    svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

git_modified() {
    local a=`git status -s --porcelain 2> /dev/null| grep "^\s*M"`
    if [ -n "$a" ]; then
        echo "*"
    fi
}

git_commit_not_pushed() {
    local a
    local rc
    if [ "$__branch" == "(no branch)" ]; then
        return
    fi
    # no remote branch
    if ! `git branch -r 2>/dev/null | grep -q $__branch` ; then
        echo "^^"
        return
    fi
    # commits not pushed
    a=`git log origin/$__branch..$__branch 2>/dev/null`
    rc=$?
    if [ "$rc" != 0 ] || [ -n "$a" ]; then
        echo "^"
    fi
}

#BLACK="\[\033[0;38m\]"
BLACK="\[\033[0;0m\]"
RED="\[\033[0;31m\]"
RED_BOLD="\[\033[01;31m\]"
BLUE="\[\033[01;94m\]"
GREEN="\[\033[0;32m\]"

if [ "$EUID" = 0 ]; then
    __first_color=$RED
else
    __first_color=$GREEN
fi
#export PS1="$__first_color\u$GREEN@\h $RED_BOLD\W $BLUE\$(parse_git_branch)\$(parse_svn_branch)$BLUE\\$ \${?##0} $BLACK"
#unset __first_color
#export PS1="$GREEN\u@\h $RED_BOLD\W $BLUE\$(parse_git_branch)\$(parse_svn_branch)$BLACK\$ "

export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    local EXIT="$?"
    if [ "$EXIT" = 0 ]; then
        EXIT=""
    fi

    #PS1="$__first_color\u$BLUE@\h $RED_BOLD\W $BLUE\$(parse_git_branch)\$(parse_svn_branch)$BLUE\\$ $EXIT $BLACK"
    PS1="$__first_color\u$BLUE@\h $RED_BOLD\W $BLUE\$(parse_git_branch)\$(parse_svn_branch)$BLUE\\$ $EXIT $BLACK"
}

#PS1="\[\e[32m\]\u@\h:\[\e[1;31m\]\w \[\033[01;34m\]\$(parse_git_branch)\$(parse_svn_branch)\[\033[00m\]$\[\033[00m\] "
#PS1="\[\e[32m\]\u@\h:\[\e[31m\]\w \[\033[34m\]\$(parse_git_branch)\[\033[00m\]$\[\033[00m\] "

alias commit_ui_wrapper='/mswg/release/git_wrapper_ui_pygtk/commit_ui_wrapper.py'

alias ww='echo -n "puts [expr 1 + [clock format [clock seconds] -format %U ]]; exit" | tclsh'
alias tkcvs='/mswg2/opt/bin/tkcvs'

alias la='ls -a --color'
alias ll='ls -l --color'
alias ltr='ls -ltr --color'

alias greset='git reset HEAD'
alias gstatus='git status'
alias gstash='git stash'
alias glist='gstash list'
alias gshow='gstash show'
alias glog='git log --oneline'
alias gcheckout='git checkout HEAD'
alias gupdate='git remote update'

alias gfetch2tall='git fetch /mswg/git/FabricIT/tallmaple.git master'
alias gpush2tall='git push ssh://roid@fit15/mswg/git/FabricIT/tallmaple.git refs/heads/master:refs/heads/master'

alias grebase='git rebase --merge FETCH_HEAD'
alias gcommit='/mswg/release/git_wrapper_ui_pygtk/commit_ui_wrapper.py'

QSTAT_PASS="pyryrebe@"
QSTAT_DIR="/mswg/utils/bin/new_qstat"
alias qstat="$QSTAT_DIR/qstat.sh"
qfree() {
    local h="$1"
    if [ -z "$h" ]; then
        $QSTAT_DIR/qfree.sh
        return $?
    fi
    $QSTAT_DIR/qfree.sh -h "$h" "$QSTAT_PASS"
    return $?
}
qalloc() {
    local h="$1"
    if [ -z "$h" ]; then
        $QSTAT_DIR/qalloc.sh
        return $?
    fi
    $QSTAT_DIR/qalloc.sh -h "$h" "$QSTAT_PASS"
    return $?
}
alias qstat_orca='qstat -cl_dep Management | grep Orca'
#export PS1='\[\e[0;35m\][\[\e[0m\]\[\e[0;36m\]\u\[\e[0m\]\[\e[0;35m\]@\[\e[0m\]\[\e[0;33m\]\h\[\e[0m\] \[\e[0;34m\]\W\[\e[0m\]\[\e[0;35m\]]\$\[\e[0m\] '

export MINI_REG='/mswg/projects/test_suite2/conf/confdir/switchx/system'
alias ibminireg='/mswg/projects/test_suite2/utils/switchx/sx_ib_mini_reg.py'
alias ethminireg='/mswg/projects/test_suite2/utils/switchx/sx_eth_mini_reg.py'

alias unixtime='date +"%s"'

enable_debug_libiscsi() {
    echo 1 > /sys/module/libiscsi/parameters/debug_libiscsi_conn
    echo 1 > /sys/module/libiscsi/parameters/debug_libiscsi_session
}

enable_debug_tgtd() {
    tgtadm --mode system --op update --name debug --value on
}

alias sg1="ssh root@172.30.49.13"
alias workbench="ssh root@172.30.11.132"
alias rcon="$HOME/scripts/rcons"

export mlnx_regression_dir='/mswg/projects/test_suite2'
export mlnx_mtr_regression_dir='/.autodirect/mtrmswg/projects/test_suite2'
export mlnx_mlxlib_dir='/usr/lib/python2.6/site-packages/mlxlib'

show_colors() {
    for b in `seq 0 1` ; do
        for i in `seq 9` ; do
            for j in `seq 9` ; do
                bb=""
                if ((b > 0)) ; then bb="1;" ; fi
                x="xxxxxxxxx"
                echo -e "$b,$i,$j->\e[${bb}3${j};4${i}m$x\e[0m"
    done ; done ; done
}

show_csv() {
    cat "$1" | column -s, -t | less -#2 -N -S
}

hca_rate() {
    for i in `ls -1 /sys/class/infiniband/mlx4_*/ports/*/rate` ; do 
        echo "$i -> `cat $i`"
    done
}

alias cpu_performance='/labhome/roid/scripts/cpu_performance.sh'
#/swgwork/performance/ToolKit/cpu_performance.sh
alias mlnxperftuner='/swgwork/performance/ToolKit/mlnxperftuner'
alias mlnxperfstatus='/swgwork/performance/ToolKit/perf_status'


#/advg/bin/cx3_linkup.py
alias rreboot='/mswg/utils/bin/rreboot'

tabs2spaces_py() {
    find . -type f -name "*.py" -exec sed -i -e 's/^M$//' -e 's/\t/    /g' {} ';'
}

function extract_rpm() {
    rpm2cpio $1 | cpio -idmv
}

function _setup_rpmbuild_env() {
    if [ -f ~/.rpmmacros ]; then
        return
    fi
    mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
    cat > ~/.rpmmacros << EOF
%_topdir %(echo $HOME)/rpmbuild
%_tmppath	%{_topdir}/tmp
%_smp_mflags  -j3
%__arch_install_post   /usr/lib/rpm/check-rpaths   /usr/lib/rpm/check-buildroot
EOF
}

vm() {
    local host=""
    local arg=$1
    local m=""
    local n=""

    m=${arg%-*}
    n=${arg#*-}

    case "$arg" in
        7-*)    host="r-sw-iris07-vm$n" ;;
        44-*)   host="rsws44-vm$n" ;;
    esac

    if [ -z "$host" ] ;then
        echo "No host configured." > /dev/stderr
        return 1
    fi
    set_konsole_title.sh "$host"
    ssh -X root@$host
}

function ssh1() {
    local h=""
    local c="$*"
    local opt="$1"
    local opt1
    while [ -n "$opt" ]; do
        opt="$1"
        opt1=${opt##-*}
        if [ -z "$opt1" ]; then
            shift
            continue
        fi
        if (( `echo $opt | grep -c "="` )); then
            shift
            continue
        fi
        h=$opt
        break
    done
    set_konsole_title.sh "$h"
    /usr/bin/ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -X -o ConnectTimeout=3 $c
    if [ -n "$KONSOLE_DCOP_SESSION" ]; then
        echo "-- closed session: $h --"
    fi
    set_konsole_title.sh "`whoami`@`hostname`"
}

function index-path2
{
    DIR=${1:-.}
    if [ "$DIR" == "." ]; then
        echo "clean"
        rm -f cscope.*
    fi
    rm -f tags
    echo "index"
    find $DIR -name '*.[ch]' -o -name '*.cpp' -o -name "*.cc" -o -name "*.hpp" | egrep -v '#|~|cscope' >> cscope.files
    cat cscope.files | xargs ctags -a
    find $DIR -name '*.py' | xargs ctags -a --c++-kinds=+p --fields=+iaS --extra=+q
    /usr/bin/cscope -b -q -i cscope.files
}

function index-path-kernel
{
    rm -f cscope.*
    rm -f tags
#                drivers/block \
#                drivers/target \
#                include/target \
#                include/scsi \
#                net/core \
#                net/sched \
#                net/netlink \
    for path in drivers/infiniband \
                drivers/net/ethernet/mellanox \
                drivers/net/vxlan.c \
                net \
                lib \
                kernel \
                arch/ia64/ \
                arch/x86_64/ \
                include/asm-generic/ \
                include/net \
                include/rdma \
                include/linux \
                include/uapi/linux include/uapi/rdma include/uapi/scsi include/uapi/asm-generic \
                ; do
        echo "index $path"
        find $path -name '*.[ch]' -o -name '*.cpp' | egrep -v '#|~|cscope' >> cscope.files
    done
    echo "tags"
    cat cscope.files | xargs ctags -a
    echo "cscope"
    /usr/bin/cscope -b -q -k -i cscope.files
}

function index-path-kernel2
{
    echo "index"
    find  $LNX                                                                \
        -path "$LNX/arch/*" ! -path "$LNX/arch/i386*" -prune -o               \
        -path "$LNX/include/asm-*" ! -path "$LNX/include/asm-i386*" -prune -o \
        -path "$LNX/tmp*" -prune -o                                           \
        -path "$LNX/Documentation*" -prune -o                                 \
        -path "$LNX/scripts*" -prune -o                                       \
        -path "$LNX/drivers*" -prune -o                                       \
            -name "*.[chxsS]" -print > cscope.files
    echo "tags"
    rm -f tags
    cat cscope.files | xargs ctags -a
    echo "cscope"
    /usr/bin/cscope -b -q -k -i cscope.files
}

tsdaemon_watch() {
    local f=${1:-/tmp/tsdaemon.log}
    watch -d -n10 " cat $f | egrep \"(cmd=|optimize_conf)\" | cut -d\  -f13-14 | tail -n 20"
}

alias ssr='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l root'


gerrit_set_changeid() {
    local a="$1"
    if [ "$a" = "false" ]; then
        git config --bool --add gerrit.createChangeId false
    else
        git config --bool --add gerrit.createChangeId true
#        git config --bool --unset-all gerrit.createChangeId
    fi

    echo "gerrit.createChangeId: `git config --bool --get gerrit.createChangeId`"
}

set_konsole_title() {
    local m="$@"
    echo -ne "\033]2;$m\007"
}
