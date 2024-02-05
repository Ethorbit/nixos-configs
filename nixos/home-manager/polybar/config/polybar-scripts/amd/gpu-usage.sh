#!/usr/bin/env bash
[ ! $(command -v radeontop) ] && echo "" && exit
echo $(radeontop -l 1 -d - -i 1 | grep --line-buffered -oP "gpu \K\d{1,3}")%
