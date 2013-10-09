function jedit() {
  if [[ "$1" != "" ]]; then
    if [[ "$2" == "" ]]; then
      echo "Usage: jedit [name <command>]"
      return
    fi
    name=$1
    shift
    echo $name=$* >> ~/.zsh/jumps
    echo Added $name to jumps file
  else
    vim $HOME/.zsh/jumps
  fi
}

function jump() {
  NewDir=`egrep "^$1=" $HOME/.zsh/jumps | sed 's/^.*=//'`;
  eval $NewDir
}

function _jump() {
  reply=(`cat $HOME/.zsh/jumps | sed 's/=.*$//'`);
}

compctl -K _jump jump
