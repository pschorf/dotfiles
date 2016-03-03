PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EMAIL="pschorf2@gmail.com"
export NAME="Paul Schorfheide"
export SMTPSERVER="smtp.gmail.com"

envfile="$HOME/.gnupg/gpg-agent.env"
if [[ -e "$envfile" ]] && kill -0 $(grep GPG_AGENT_INFO "$envfile" | cut -d: -f 2) 2>/dev/null; then
      eval "$(cat "$envfile")"
else
      eval "$(gpg-agent --daemon --enable-ssh-support --write-env-file "$envfile")"
fi
export GPG_AGENT_INFO  # the env file does not contain the export statement
export SSH_AUTH_SOCK   # enable gpg-agent for ssh

export PATH=$PATH:/Users/paul/miniconda2/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:/usr/local/bin:$PATH"
export PATH="$PATH:/Users/paul/tools/lein"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PATH=$PATH:/usr/local/texlive/2015/bin/x86_64-darwin
export PATH=$PATH:/Users/paul/node_modules/typescript/bin
export PATH=$PATH:/Users/paul/tools/rakudo-2015.12/install/bin
export PATH=$PATH:/home/paul/tools/sbt/bin
