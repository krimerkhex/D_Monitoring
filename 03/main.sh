#!/bin/bash

function getFontColor {
    local temp='\033[37m'
    case $1 in
        2) temp='\033[31m';;
        3) temp='\033[32m';;
        4) temp='\033[34m';;
        5) temp='\033[35m';;
        6) temp='\033[39m';;
    esac
    echo -e "$temp"
}
 function getBackColor {
    local temp='\033[47m'
    case $1 in
        2) temp='\033[41m';;
        3) temp='\033[42m';;
        4) temp='\033[44m';;
        5) temp='\033[45m';;
        6) temp='\033[40m';;
    esac
    echo -e "$temp"
}
 outputSettings() {
    echo -e "$(getFontColor $1)$(getBackColor $2)HOSTNAME\033[0m = $(getFontColor $3)$(getBackColor $4)$(hostname)\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)TIMEZONE\033[0m = $(getFontColor $3)$(getBackColor $4)$(timedatectl show --property=Timezone --value)\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)USER\033[0m = $(getFontColor $3)$(getBackColor $4)$(whoami)\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)OS\033[0m = $(getFontColor $3)$(getBackColor $4)$(lsb_release -ds)\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)DATE\033[0m = $(getFontColor $3)$(getBackColor $4)$(date +"%d %b %Y %T")\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)UPTIME\033[0m = $(getFontColor $3)$(getBackColor $4)$(uptime -p)\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)UPTIME_SEC\033[0m = $(getFontColor $3)$(getBackColor $4)$(awk '{print $1}' /proc/uptime)\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)IP\033[0m = $(getFontColor $3)$(getBackColor $4)$(hostname -I | awk '{print $1}')\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)MASK\033[0m = $(getFontColor $3)$(getBackColor $4)$(ip -o -f inet addr show | awk '/scope global/ {print $4}')\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)GATEWAY\033[0m = $(getFontColor $3)$(getBackColor $4)$(ip route | awk '/default via/ {print $3}')\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)RAM_TOTAL\033[0m = $(getFontColor $3)$(getBackColor $4)$(free -g | awk '/Mem:/ {print $2}') GB\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)RAM_USED\033[0m = $(getFontColor $3)$(getBackColor $4)$(free -g | awk '/Mem:/ {print $3}') GB\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)RAM_FREE\033[0m = $(getFontColor $3)$(getBackColor $4)$(free -g | awk '/Mem:/ {print $4}') GB\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)SPACE_ROOT\033[0m = $(getFontColor $3)$(getBackColor $4)$(df -m / | awk '/\/$/ {print $2}') MB\033[0m"
    echo -e "$(getFontColor $1)$(getBackColor $2)SPACE_ROOT_USED\033[0m = $(getFontColor $3)$(getBackColor $4)$(df -m / | awk '/\/$/ {print $4}') MB\033[0m"
}
 if [[ $# -eq 4 ]]; then
    if ! [[ $1 -eq $2 ]]; then
        if ! [[ $3 -eq $4 ]]; then
            for i in $1 $2 $3 $4; do
                if [[ $i -le 0 || $i -ge 7 ]]; then
                    echo "Color parameter out of range, please restart the script with correct variables"
                    exit 1
                fi
            done
            outputSettings $1 $2 $3 $4
        else
            echo "You gave equal values for rvalue color, please restart the script with correct variables"
        fi
    else
        echo "You gave equal values for lvalue color, please restart the script with correct variables"
    fi
else
    echo "Incorrect count of arguments, please restart the script with correct variables"
fi