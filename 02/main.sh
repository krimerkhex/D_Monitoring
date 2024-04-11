#!/bin/bash

file_output() {
    filename=$(date '+%d_%m_%Y_%H_%M_%S').status;
    echo -e "System Information:\n" > $filename;
    echo "HOSTNAME = $(hostname)" >> $filename;
    echo "TIMEZONE = $(timedatectl show --property=Timezone --value)" >> $filename;
    echo "USER = $(whoami)" >> $filename;
    echo "OS = $(lsb_release -ds)" >> $filename;
    echo "DATE = $(date +"%d %b %Y %T")" >> $filename;
    echo "UPTIME = $(uptime -p)" >> $filename;
    echo "UPTIME_SEC = $(awk '{print $1}' /proc/uptime)" >> $filename;
    echo "IP = $(hostname -I | awk '{print $1}')" >> $filename;
    echo "MASK = $(ip -o -f inet addr show | awk '/scope global/ {print $4}')" >> $filename;
    echo "GATEWAY = $(ip route | awk '/default via/ {print $3}')" >> $filename;
    echo "RAM_TOTAL = $(free -g | awk '/Mem:/ {print $2}') GB" >> $filename;
    echo "RAM_USED = $(free -g | awk '/Mem:/ {print $3}') GB" >> $filename;
    echo "RAM_FREE = $(free -g | awk '/Mem:/ {print $4}') GB" >> $filename;
    echo "SPACE_ROOT = $(df -m / | awk '/\/$/ {print $2}') MB" >> $filename;
    echo "SPACE_ROOT_USED = $(df -m / | awk '/\/$/ {print $4}') MB" >> $filename;
}

if [[ $# == 0 ]]; then
    echo "HOSTNAME = $(hostname)"
    echo "TIMEZONE = $(timedatectl show --property=Timezone --value)"
    echo "USER = $(whoami)"
    echo "OS = $(lsb_release -ds)"
    echo "DATE = $(date +"%d %b %Y %T")"
    echo "UPTIME = $(uptime -p)"
    echo "UPTIME_SEC = $(awk '{print $1}' /proc/uptime)"
    echo "IP = $(hostname -I | awk '{print $1}')"
    echo "MASK = $(ip -o -f inet addr show | awk '/scope global/ {print $4}')"
    echo "GATEWAY = $(ip route | awk '/default via/ {print $3}')"
    echo "RAM_TOTAL = $(free -g | awk '/Mem:/ {print $2}') GB"
    echo "RAM_USED = $(free -g | awk '/Mem:/ {print $3}') GB"
    echo "RAM_FREE = $(free -g | awk '/Mem:/ {print $4}') GB"
    echo "SPACE_ROOT = $(df -m / | awk '/\/$/ {print $2}') MB"
    echo "SPACE_ROOT_USED = $(df -m / | awk '/\/$/ {print $4}') MB"

    read -p "Throw this system information into file? [y[Y] / n[N]] " user_input

    if [[ $user_input == "Y" || $user_input == "y" ]]; then
        $(file_output)
    else 
        echo "it's you choise, dude."
    fi
else
    echo "n/a"
fi
