#!/bin/bash

function getFontColor {
    local temp='\033[37m'
    case $1 in
        2) temp='\033[31m';;
        3) temp='\033[32m';;
        4) temp='\033[34m';;
        5) temp='\033[35m';;
        6) temp='\033[30m';;
        0) temp='\033[36m)';;
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
        0) temp='\033[46m)';;
    esac
    echo -e "$temp"
}

function getBackName {
    local temp='white'
    case $1 in
        2) temp='red';;
        3) temp='green';;
        4) temp='blue';;
        5) temp='purple';;
        6) temp='black';;
        0) temp='cyan';;
    esac
    echo -e "$temp"
}

function getFontName {
    local temp='white'
    case $1 in
        2) temp='red';;
        3) temp='green';;
        4) temp='blue';;
        5) temp='putple';;
        6) temp='black';;
        0) temp='cyan';;
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
    echo ""
    if [[ $1 == 0 ]]; then
        echo "Column 1 background = default ($(getBackName $1))"
    else
        echo "Column 1 background = $1 ($(getBackName $1))"
    fi
    if [[ $2 == 0 ]]; then
        echo "Column 1 font color = default ($(getFontName $2))"
    else
        echo "Column 1 font color = $2 ($(getFontName $2))"
    fi
    if [[ $3 == 0 ]]; then
        echo "Column 2 background = default ($(getBackName $3))"
    else    
        echo "Column 2 background = $3 ($(getBackName $3))"
    fi  
    if [[ $4 == 0 ]]; then
        echo "Column 2 font color = default ($(getFontName $4))"
    else
        echo "Column 2 font color = $4 ($(getFontName $4))"
    fi
}

if [[ $# -eq 0 ]]; then
    lvalue_back=$(grep column1_background settings.conf | awk -F = '{printf("%i", $2)}');
    lvalue_font=$(grep column1_font_color settings.conf | awk -F = '{printf("%i", $2)}');
    rvalue_back=$(grep column2_background settings.conf | awk -F = '{printf("%i", $2)}');
    rvalue_font=$(grep column2_font_color settings.conf | awk -F = '{printf("%i", $2)}');
    if ! [[ lvalue_back -eq lvalue_font ]]; then
        if ! [[ rvalue_back -eq rvalue_font ]]; then
            for i in lvalue_back lvalue_font rvalue_back rvalue_font; do
                if ! [[ -z $i ]]; then
                    if [[ $i -le -1 || $i -ge 7 ]]; then
                        echo "Color parameter out of range, please restart the script with correct variables"
                        exit 1
                    fi
                fi
            done
            outputSettings $lvalue_back $lvalue_font $rvalue_back $rvalue_font
        else
            echo "You gave equal values for rvalue color, please restart the script with correct variables"
        fi
    else
        echo "You gave equal values for lvalue color, please restart the script with correct variables"
    fi
else
    echo "Incorrect count of arguments, please restart the script with correct variables"
fi
