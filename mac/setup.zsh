# load colors (for echo-ing)
autoload colors;
colors;

echo "# load colors (for echo-ing)" >> $HOME/.zshrc
echo "autoload colors;" >> $HOME/.zshrc
echo "colors;" >> $HOME/.zshrc

echo "\n# notify user" >> $HOME/.zshrc
echo "echo \$fg_bold[green]\"loading\"\$reset_color\": ~/.zshrc\"" >> $HOME/.zshrc

echo "\n# color the CLI" >> $HOME/.zshrc
echo "export CLICOLOR=1" >> $HOME/.zshrc
echo "export LSCOLORS=GxFxCxDxBxegedabagaced" >> $HOME/.zshrc

echo "\n# format the prompt" >> $HOME/.zshrc
echo "PS1=\"%{\$fg[green]%}%n@%m%{\$reset_color%}:%{\$fg[cyan]%}%1~%{\$reset_color%} %% \"" >> $HOME/.zshrc

echo $fg_bold[red]"Run"$reset_color" :source ~/.zshrc"