
sudo apt-get install -y curl

# =========================================================================
# SQL SEVER DRIVER
# =========================================================================
sudo su 

# download the key
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# add sources to the package manager
curl https://packages.microsoft.com/config/ubuntu/19.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

exit

# update the sources
sudo apt update -y

# install the package(s)
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql17

# install mssql tools
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools

echo -e "\n# MSSQL tools" >> $HOME/.bash_profile
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> $HOME/.bash_profile

echo -e "\n# MSSQL tools" >> $HOME/.zshrc
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> $HOME/.zshrc

# =========================================================================
# ODBC
# =========================================================================

# install os packages
sudo apt-get install unixodbc-dev

# ensure bash is sourced (with new addtions)
echo -e "\e[31mRun\e[0m source ~/.zshrc"