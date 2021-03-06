# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="ys"
#ZSH_THEME="clean"
ZSH_THEME="frosty"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
 export UPDATE_ZSH_DAYS=30 #13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
 DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
 COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git emoji emoji-clock)

source $ZSH/oh-my-zsh.sh
# Customize to your needs...

# Old, BASH compatible method
#export PATH=/usr/lib/surfraw:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/colton/bin:/home/colton/fbin:/usr/lib/surfraw:~/.gem/ruby/2.0.0/bin:~/.gem/ruby/2.1.0/bin
path=()
path+=/usr/local/bin
path+=/usr/bin
path+=/bin
path+=/usr/local/sbin
path+=/usr/sbin
path+=/sbin
path+=/opt/java/bin
path+=/opt/java/db/bin
path+=/opt/java/jre/bin
path+=/usr/bin/vendor_perl
path+=/usr/bin/core_perl
path+=/usr/lib/surfraw
path+=~/bin
path+=~/fbin
path+=~/.gem/ruby/2.0.0/bin
path+=~/.gem/ruby/2.1.0/bin
path+=~/.gem/ruby/2.2.0/bin
path+=~/.gem/ruby/2.3.0/bin
path+=~/.gem/ruby/2.4.0/bin
path+=~/sadm
path+=/opt/sandman/bin
# Only the ones that exist
path=($^path(N))

FPATH="$HOME/.files/.zsh_autocomplete:$FPATH"
HISTSIZE=1000000 # 10000
SAVEHIST=1000000

# Enable bash-style interactive comments
setopt interactivecomments

# Use ^W instead of interactive comments?
bindkey "^W" push-input

# Useful aliases and tweaks
if [ -f ~/.alias ]; then
	source ~/.alias
fi
if [ -f ~/.zshhacks ]; then
	source ~/.zshhacks
fi
if [[ "$(hostname)" == "Toronto" ]]; then
#	eval $(ssh-agent)
	eval $(keychain --eval --agents ssh -Q --quiet)
fi

# Regex reverse search! https://coderwall.com/p/-jvcag/zsh-reverse-history-search-with-regex
bindkey '^R' history-incremental-pattern-search-backward
bindkey "^P" vi-up-line-or-history
bindkey "^N" vi-down-line-or-history
setopt rm_star_silent
export REPORTTIME=2

PATH="/home/colton/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/colton/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/colton/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/colton/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/colton/perl5"; export PERL_MM_OPT;

export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
export GPG_TTY=$(tty)
