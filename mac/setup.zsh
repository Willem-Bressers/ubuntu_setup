# load colors (for echo-ing)
autoload colors;
colors;

# remove the old files
rm $HOME/.zshrc
rm $HOME/.bashrc
rm $HOME/.bash_profile

# create new zsh config file
touch $HOME/.zshrc
touch $HOME/.bashrc
touch $HOME/.bash_profile

# ensure the profile is loaded everywhere
echo "\n# load the custom profile" >> $HOME/.zshrc
echo "source ~/.bashrc" >> $HOME/.zshrc
echo "\n# load the custom profile" >> $HOME/.bash_profile
echo "source ~/.bashrc" >> $HOME/.bash_profile

echo "\n# notify user" >> $HOME/.bashrc
echo "echo \"\\e[1;32mloading$reset_color: ~/.bashrc\"" >> $HOME/.bashrc

echo "\n# color the CLI" >> $HOME/.bashrc
echo "export CLICOLOR=1" >> $HOME/.bashrc
echo "export LSCOLORS=GxBxCxDxexegedabagaced" >> $HOME/.bashrc

echo "\n# get current git branch" >> $HOME/.bashrc
echo "parse_git_branch() {\n\tgit branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'\n}" >> $HOME/.bashrc

echo "\n# format the prompt" >> $HOME/.bashrc
echo "PS1=\"\\e[1;32m%n$reset_color@\\e[1;36m%1~\\e[1;33m\$(parse_git_branch)$reset_color $ \"" >> $HOME/.bashrc

# ensure bash is sourced (with new addtions)
echo "\e[1;31mRun"$reset_color": source ~/.bashrc"