function jedit() {
  vim ~/.zsh/jumps
}

function jump() {
  NewDir=`egrep "^$1=" ~/.zsh/jumps | sed 's/^.*=//'`;
  eval cd $NewDir
}

function _jump() {
  reply=(`cat ~/.zsh/jumps | sed 's/=.*$//'`);
}

compctl -K _jump jump
