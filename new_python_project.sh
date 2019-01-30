
read -p "Project name? " name;

# Create project folder
cd ~/projects
cookiecutter https://github.com/drivendata/cookiecutter-data-science $name

# setup virtual environment
mkvirtualenv $name

# install requirements
cd ~/projects/$name
make requirements
make test_environment

# setup
touch .env

# initialize git
git init
git add .
git commit -am "Initial commit"