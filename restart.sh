#!/bin/sh

screen -S minecraft -X stuff "broadcast &cServer rebooting in 3 minutes."
screen -S minecraft -X eval "stuff \015"
sleep 60
screen -S minecraft -X stuff "broadcast &cServer rebooting in 2 minutes."
screen -S minecraft -X eval "stuff \015"
sleep 60
screen -S minecraft -X stuff "broadcast &cServer rebooting in 1 minute."
screen -S minecraft -X eval "stuff \015"
sleep 60
screen -S minecraft -X stuff "broadcast &cServer rebooting..."
screen -S minecraft -X eval "stuff \015"
screen -S minecraft -X stuff "kickall Rebooting. Please reconnect in one minute."
screen -S minecraft -X eval "stuff \015"
sleep 5
screen -S minecraft -X stuff "stop"
screen -S minecraft -X eval "stuff \015"
sleep 15

screen -S minecraft -X quit

sleep 15

cd /home/deltagi/minecraft
./start.sh
 