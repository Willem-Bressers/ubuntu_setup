# install OS dependencies
sudo apt-get install -y software-properties-common python-software-properties openjdk-8-jdk-headless

# download minecraft server
wget https://launcher.mojang.com/v1/objects/4d1826eebac84847c71a77f9349cc22afd0cf0a1/server.jar -O $HOME/minecraft_server.1.15.1.jar

# start minecraft server
java -Xmx1024M -Xms1024M -jar minecraft_server.1.15.1.jar nogui
