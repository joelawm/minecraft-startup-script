#!/bin/sh
# Start the Minecraft server in a detached screen session.
# Lifecycle is managed by systemd (minecraft.service).

cd /home/deltagi/minecraft || exit 1

echo "Starting Minecraft server..."
/usr/bin/screen -d -m -S minecraft \
    /usr/bin/java -server -Xms4G -Xmx4G -jar spigot.jar
echo "Minecraft server started (screen session: minecraft)"