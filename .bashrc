if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias vp='vim PKGBUILD'
alias vs='vim SPLITBUILD'

# vim stuff
export EDITOR=vim
export VISUAL=vim
alias vi=vim

# Arch latest news
 if [ "sudo pacman -Syu" ] && [[ $(ping -c1 www.google.com 2>&-) ]]; then
 	# The characters "£, §" are used as metacharacters. They should not be encountered in a feed...
	echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | awk ' NR == 1 {while ($0 !~ /<\/item>/) {print;getline} sub(/<\/item>.*/,"</item>") ;print}' | sed -e ':a;N;$!ba;s/\n/ /g') | \
	sed -e 's/&amp;/\&/g
	s/&lt;\|&#60;/</g
	s/&gt;\|&#62;/>/g
	s/<\/a>/£/g
	s/href\=\"/§/g
	s/<title>/\\n\\n\\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m ::\\n/g
	s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
	s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
	s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
	s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
	s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
	s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
	s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
	s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
	s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
	s/<!\[CDATA\[\|\]\]>//g
	s/\|>\s*<//g
	s/ *<[^>]\+> */ /g
	s/[<>£§]//g')\n\n";
fi

# prompt
PS1='\n┌─┤\e[38;5;1m\u\e[0m├─┤\e[38;5;1m\w\e[0m├──╼\n└─╼ '
