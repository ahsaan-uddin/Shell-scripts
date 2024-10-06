#!/bin/bash

set -euo pipefail
##For disk space monitoring---------

available_space=$( df -h --total | grep "total" | awk {'print $5'} | tr -d ' %' )
disk_space_threshold=80

if [[ $available_space -le $disk_space_threshold ]]
then
        echo "low space $available_space"
else
        echo "enough space $available_space"
fi
#-------------------------------------------------------------------------
##For memory usage monitoring--------

available_memory=$( free -h | grep "Mem" | awk {'print$4'} | tr -d 'Mi' )
memory_threshold=500

if [[ $available_memory -le $memory_threshold ]]
then
        echo "memory space running out. current space- $available_memory M"
else
        echo "sufficient memory space. current space- $available_memory M"
fi
#----------------------------------------------------------------------
##For Cpu utilization monitoring-------

current_cpu_usage=$( uptime | awk -F'load average:' '{print $2}' | awk '{print $1 + $2 + $3}' )
cpu_threshold=1

echo "$current_cpu_usage"
if (( $(echo "$current_cpu_usage >= $cpu_threshold" | bc -l) ))
then
        echo "CPU usage is high. current usage- $current_cpu_usage %"
else
        echo "CPU usage is moderate. no need for action. current usage- $current_cpu_usage %"

fi
#----------------------------------------------------------------------
# Logging

log_file="resource_usage.log"
log_path="/home/devops/logsdir"

if [ -f /home/devops/logsdir/resource_usage.log ]
then
        echo "$available_space $available_memory $current_cpu_usage" > /home/devops/logdir/resource_usage.log

else
        if [ -d $log_path ]
        then
                touch $log_file
        else
                mkdir -p $log_path
                touch $log_path
                echo "$available_space $available_memory $current_cpu_usage" > $log_path/$log_file

        fi
exit
fi
