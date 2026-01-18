#!/bin/bash

LOG_FILE="/var/log/system_health.log"
DATE=$(date)

echo "===== SYSTEM HEALTH REPORT ====="
echo "Date: $DATE"
echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
echo "CPU Usage: $CPU%"

MEM_USED=$(free -h | grep "Mem:" | awk '{print $3}')
MEM_TOTAL=$(free -h | grep "Mem:" | awk '{print $2}')
echo "Memory Usage: $MEM_USED / $MEM_TOTAL"

DISK=$(df -h / | awk 'NR==2 {print $1 " " $5 " used"}')
echo "Disk: $DISK"

IP=$(hostname -I | awk '{print $1}')
if ping -c 1 google.com &> /dev/null; then
    echo "Network: $IP - OK (ping success)"
else
    echo "Network: $IP - Connectivity FAILED"
fi

SSH=$(systemctl is-active ssh)
APACHE=$(systemctl is-active apache2 2>/dev/null || echo "inactive")
echo "Services: sshd $SSH, apache2 $APACHE"

{
    echo "===== SYSTEM HEALTH REPORT ====="
    echo "Date: $DATE"
    echo "Hostname: $(hostname)"
    echo "CPU Usage: $CPU%"
    echo "Memory Usage: $MEM_USED / $MEM_TOTAL"
    echo "Disk: $DISK"
    echo "Network: $IP"
    echo "Services: sshd $SSH, apache2 $APACHE"
    echo "================================"
} | sudo tee -a $LOG_FILE > /dev/null

echo "Report saved to $LOG_FILE"
echo "================================"
