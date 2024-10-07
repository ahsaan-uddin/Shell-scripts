#!/bin/bash

set -euo pipefail
date=$(date)
alert_message=""


##For disk space monitoring---------

used_space=$( df -h --total | grep "total" | awk {'print $5'} | tr -d ' %' )
disk_space_threshold=10

if [[ $used_space -ge $disk_space_threshold ]]
then
        alert_message+="Warning!: diskspace running out. current usage= $used_space %  "
fi

#-------------------------------------------------------------------------
##For memory usage monitoring--------

available_memory=$( free -h | grep "Mem" | awk {'print$4'} | tr -d 'Mi' )
memory_threshold=500

if [[ $available_memory -le $memory_threshold ]]
then
        alert_message+=" Warning! memory space running out. current space- $available_memory M"
fi

#----------------------------------------------------------------------
##For Cpu utilization monitoring-------

current_cpu_usage=$( uptime | awk -F'load average:' '{print $2}' | awk '{print $1 + $2 + $3}' )
cpu_threshold=0

echo "$current_cpu_usage"
if (( $(echo "$current_cpu_usage >= $cpu_threshold" | bc -l) ))
then
        alert_message+="  CPU usage is high. current usage- $current_cpu_usage % "

fi

#----------------------------------------------------------------------
# Logging

if [ -f /home/devops/logsdir/resource_usage.log ]
then
        echo "$date - Current disk usage = $used_space % | Current available memory = $available_memory Mi | Current CPU usage = $current_cpu_usage %" >> /home/devops/logsdir/resource_usage.log

else
        if [ -d /home/devops/logsdir ]
        then
                touch /home/devops/logsdir/resource_usage.log
        else
                mkdir -p /home/devops/logsdir
                touch /home/devops/logsdir/resource_usage.log
                echo "$date - Current disk usage = $used_space % | Current available memory = $available_memory Mi | Current CPU usage = $current_cpu_usage %" >> /home/devops/logsdir/resource_usage.log
        fi
fi

#-----------------------------------------------------------------------------------
#mail config

if [[ -n $alert_message ]]
then
        echo -e "Subject: System Alert! \n\n $alert_message" | sendmail -v #Your Destination Mail Here
fi
