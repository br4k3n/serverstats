#!/bin/bash

echo "==== CPU Usage ===="
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed 's/,/ /g' | awk '{print 100 - $8}')
echo "CPU Usage: $cpu_usage %"

echo "==== Memory Usage===="
read total used <<< $(free -m | awk '/Mem:/ {print $2, $3}')
mem_usage=$(( 100 * used / total ))
echo "Total: ${total}MB Used: ${used}MB Usage: ${mem_usage}%"

echo "==== Disk Usage ===="
df -h / | awk 'NR==2 {print "Total: "$2" Used: "$3" Free: "$4" Usage: "$5}'

echo "==== Top 5 Processes by CPU ===="
ps aux --sort=-%cpu | head -n 6

echo "==== Top 5 Processes by Memory ===="
ps aux --sort=-%mem | head -n 6
