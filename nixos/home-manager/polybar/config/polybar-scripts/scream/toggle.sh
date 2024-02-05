#!/usr/bin/env bash
[ ! $(command -v scream) ] && echo "" && exit

if [[ ! -z $(pgrep -x scream) ]]; then
        killall scream
else
        scream -i virbr0 -o pulse
fi
