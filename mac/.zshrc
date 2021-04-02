# load colors (for echo-ing)
autoload colors;
colors;

# notify user
echo $fg_bold[green]"loading"$reset_color": ~/.zshrc"

# color the CLI
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# format the prompt
PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%1~%{$reset_color%} %% "

# Add local bin (for the virtualenv)
PATH=/Library/Frameworks/Python.framework/Versions/3.9/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/willem/.local/bin:/Users/willem/.local/bin

# virtualenv and virtualenvwrapper environment variables
export WORKON_HOME=/Users/willem/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/3.9/bin/python3

# source the virtualenvwrapper code
source /Library/Frameworks/Python.framework/Versions/3.9/bin/virtualenvwrapper.sh
