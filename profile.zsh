# MacPorts Installer addition on 2009-08-26_at_12:53:02: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH=/opt/local/share/man:$MANPATH
# Finished adapting your MANPATH environment variable for use with MacPorts.

export CLICOLOR=1

# exclude Mac OS X crap from tar files
export COPYFILE_DISABLE=true

export CVS_RSH=ssh

export DISPLAY=:0.0

export EDITOR="subl -w -n"

export LS_OPTIONS="--color=auto"

eval $(/usr/local/bin/gdircolors $HOME/.zsh/dir_colors)

export PAGER=less

export MANPAGER='man2html | bcat'

export PYTHONSTARTUP=$HOME/.pythonrc.py

# MacPorts Installer addition on 2009-08-30_at_02:26:17: adding an appropriate PATH variable for use with MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

export PATH=$HOME/bin:/usr/local/bin:$PATH

export PERL_LOCAL_LIB_ROOT="$HOME/perl5";
export PERL_MB_OPT="--install_base $HOME/perl5";
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5";
export PERL5LIB="$HOME/perl5/lib/perl5/darwin-thread-multi-2level:$HOME/perl5/lib/perl5";
export PATH="$HOME/perl5/bin:$PATH";

export PGHOST=localhost
