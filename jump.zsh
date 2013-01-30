function jedit() {
  vim $HOME/.zsh/jumps
}

function jump() {
  NewDir=`egrep "^$1=" $HOME/.zsh/jumps | sed 's/^.*=//'`;
  eval $NewDir
}

function _jump() {
  reply=(`cat $HOME/.zsh/jumps | sed 's/=.*$//'`);
}

compctl -K _jump jump
