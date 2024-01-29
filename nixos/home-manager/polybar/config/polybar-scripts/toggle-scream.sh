#!/bin/bash

if [[ ! -z $(pgrep -x scream) ]]; then
        killall scream
else
        scream -i virbr0 -o pulse
fi
