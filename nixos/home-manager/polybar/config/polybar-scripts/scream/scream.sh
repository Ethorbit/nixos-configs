#!/usr/bin/env bash
[ ! $(command -v scream) ] && echo "" && exit

if [[ ! -z $(pgrep -x scream) ]]; then 
    echo -e "Scream \ue0e0";
else
    echo -e "Scream \ue202";
fi  
