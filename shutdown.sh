#!/bin/sh

screen -s server -X stuff "broadcast &cServer rebooting in 2 minutes."
screen -s server -X eval "stuff \015"
sleep 60
screen -s server -X stuff "broadcast &cServer rebooting in 1 minute."
screen -s server -X eval "stuff \015"
sleep 60
screen -s server -X stuff "broadcast &cServer rebooting..."
screen -s server -X eval "stuff \015"
screen -s server -X stuff "kickall Rebooting. Please reconnect in one minute."
screen -s server -X eval "stuff \015"
sleep 5
screen -s server -X stuff "stop"
screen -s server -X eval "stuff \015"
sleep 15

screen -S minecraft -X quit
 