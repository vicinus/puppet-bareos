#!/bin/sh

self="$(readlink -f "$0")"
scriptdir="${self}.d"

if ! test -d "$scriptdir"
then
    echo "Hook directory ${scriptdir} not found!"
    exit 1
fi

fail_counter=0
if ls "$scriptdir"/* 1>/dev/null  2>&1
then
    for script in "$scriptdir"/*
    do
        "$script"
        if ! test $? -eq 0
        then
            fail_counter=$((fail_counter+1))
        fi 
    done
fi

echo "Hook execution completed!"
if test $fail_counter -gt 0
then
    echo "${fail_counter} hooks failed to execute"
    exit 2
fi

