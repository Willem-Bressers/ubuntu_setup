# load colors (for echo-ing)
autoload colors;
colors;

# create new zsh config file
touch $HOME/.zshrc

echo "# load colors (for echo-ing)" >> $HOME/.zshrc
echo "autoload colors;" >> $HOME/.zshrc
echo "colors;" >> $HOME/.zshrc

echo "\n# notify user" >> $HOME/.zshrc
echo "echo \$fg_bold[green]\"loading\"\$reset_color\": ~/.zshrc\"" >> $HOME/.zshrc

echo "\n# color the CLI" >> $HOME/.zshrc
echo "export CLICOLOR=1" >> $HOME/.zshrc
echo "export LSCOLORS=GxFxCxDxBxegedabagaced" >> $HOME/.zshrc

echo "\n# get current git branch" >> $HOME/.zshrc
echo "parse_git_branch() {\n\tgit branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'\n}" >> $HOME/.zshrc

echo "\n# format the prompt" >> $HOME/.zshrc
echo "PS1=\"%{\$fg[green]%}%n%{\$reset_color%} @ %{\$fg[cyan]%}%1~%{\$reset_color%}%{\$fg[yellow]%}\$(parse_git_branch)%{\$reset_color%} $ \"" >> $HOME/.zshrc

echo $fg_bold[red]"Run"$reset_color" :source ~/.zshrc"