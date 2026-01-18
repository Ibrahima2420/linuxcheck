# Project: System Health Script

This is a simple Bash script that checks how the computer is doing.

# What it does:
* Shows the Date, Hostname, and Uptime.
* Checks CPU and Memory(RAM) usage.
* Checks Disk space.
* Tests the Network connection.
* Checks if SSH and Apache services are running.
* Saves all this information into a log file.

# How to run it:
1. Give permission: `chmod +x system_health.sh`
2. Run with sudo: `sudo ./system_health.sh`

# Where are the logs?
The reports are saved here: `/var/log/system_health.log`
