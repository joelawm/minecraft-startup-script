# Minecraft startup script
Feel free to use this and adapt to your system, im running it on Ubuntu 20.4 lts.
Also make sure you're running the Essentials Plugin for Bukkit, this uses its broadcast system, you can change it if you'd like, but essnetials in my mind is essential.
https://dev.bukkit.org/projects/essentialsx It may change over the years, a couple years ago it was called essentials, now essentialsx. 


### Cron Job: 
```0 0,6,12,18 * * * /location/restart.sh >/dev/null 2>&1```
This restarts the server every 6 hours, you can add more as needed, my system has 32GBs of ram.
