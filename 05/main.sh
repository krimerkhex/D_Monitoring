#!/bin/bash

function fiveMaxSizeFolders() {
    echo "Total number of folders (including all nested ones) = $(ls -l $1 | grep -c ^d)"
    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    i=1
    for ((var=1; var<6; var++))
    do
        path=$(du -h $1 | sort -n | sed -n "$var"p | awk '{printf("%s", $2)}');
        size=$(du -h $1 | sort -n | sed -n "$var"p | awk '{printf("%s", $1)}');
        if ! [ -z "$path" ] && ! [ -z "$size" ]; then
            echo "$i = $path, $size"
            ((i++))
        fi
    done
}

function countingFilesByType() {
    echo "Total number of files = $(ls -laR $1 | grep "^-" | wc | awk '{print $1}')"
    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $(find $1 -type f -name "*.conf" | wc -l)"
    echo "Text files = $(find $1 -type f -name "*.txt" | wc -l)"
    echo "Executable files = $(find $1 -type f -name -executable | wc -l)"
    echo "Log files (with the extension .log) = $(find $1 -type f -name "*.log" | wc -l)"
    echo "Archive files = $(find $1 -type f -name "*.zip" -o -name "*.7z" -o -name "*.rar" -o -name "*.tar" | wc -l)"
    echo "Symbolic links = $(find $1 -type l | wc -l)"
}

function tenMaxSizeFiles() {
    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    i=1
    for ((var=1; var < 11; ++var))
    do
        path=$(find $1 -type f -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{printf($2)}');
        size=$(find $1 -type f -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{printf($1)}');
        if ! [ -z "$path" ] && ! [ -z "$size" ]; then
            echo "$i = $path, $size, ${path##*.}"
            ((i++))
        fi
    done
}

function tenMaxSizeExeFilse() {
    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    i=1
    for ((var=1; var < 11; ++var))
    do
        path=$(find $1 -type f -executable -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{printf($2)}');
        size=$(find $1 -type f -executable -exec du -h {} + | sort -hr | sed -n "$var"p | awk '{printf($1)}');
        if ! [ -z "$path" ] && ! [ -z "$size" ]; then
            echo "$i = $path, $size, $(md5sum $path | awk '{printf($1)}')"
            ((i++))
        fi
    done
}

function getInformationAboutPath() {
    echo "Information about dir $1"
    fiveMaxSizeFolders $1
    countingFilesByType $1
    tenMaxSizeFiles $1
    tenMaxSizeExeFilse $1
    echo "Script execution time (in seconds) = $(($(date +%s) - $2))"
}

startTime=$(date +%s)
if [[ $# -eq 1 ]]; then
    if [[ ${1: -1} == '/' ]]; then
        getInformationAboutPath $1 $startTime
    else
        echo "You gived path without / in end, please restart the script with correct value"
    fi
else
    echo "You gived unccorent count of parametr's, please restart the script with correct value"
fi