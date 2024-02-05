#!/bin/bash
echo $(/usr/sbin/radeontop -l 1 -d - -i 1 | grep --line-buffered -oP "gpu \K\d{1,3}")%
