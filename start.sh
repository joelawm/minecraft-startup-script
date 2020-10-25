#!/bin/sh

echo "Running server"
/usr/bin/screen -d -m -S minecraft /usr/bin/java -server -Xms4G -Xmx4G -jar spigot.jar
echo "Server Started"