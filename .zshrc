# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git aws brew emacs osx sbt vi-mode fasd)


source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export GRADLE_HOME=/Users/paul/Downloads/gradle-1.7
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/X11/bin:$GRADLE_HOME/bin
alias vi=vim

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/Users/paul/tools/lein"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/texlive/2015/bin/x86_64-darwin
export PATH=$PATH:/Users/paul/node_modules/typescript/bin
export PATH=$PATH:/Users/paul/tools/rakudo-2015.12/install/bin
export PATH=$PATH:/home/paul/tools/sbt/bin
