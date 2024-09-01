#!/bin/bash

display_metrics() {
    echo "==================== System Health Dashboard ===================="
    echo "Date and Time       : $(date)"
    
    echo "CPU Usage           : $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')%"

    memory_total=$(free -m | awk 'NR==2{print $2}')
    memory_used=$(free -m | awk 'NR==2{print $3}')
    memory_free=$(free -m | awk 'NR==2{print $4}')
    echo "Memory Usage        : $memory_used/$memory_total MB ($(( memory_used * 100 / memory_total ))%)"

    df_output=$(df -h / | awk 'NR==2')
    disk_used=$(echo $df_output | awk '{print $3}')
    disk_total=$(echo $df_output | awk '{print $2}')
    disk_percentage=$(echo $df_output | awk '{print $5}')
    echo "Disk Usage          : $disk_used/$disk_total ($disk_percentage)"

   
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    echo "==============================================================="
}

while true; do
    clear
    display_metrics
    sleep 5
done
