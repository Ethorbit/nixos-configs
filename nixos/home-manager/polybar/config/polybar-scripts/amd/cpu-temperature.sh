#!/usr/bin/env bash
[ ! $(command -v sensors) ] && echo "" && exit
TEMP=$(sensors -j k10temp-pci-00c3 2> /dev/null)
TEMP=$(echo $TEMP | jq '."k10temp-pci-00c3".Tdie.temp2_input')
TEMP=$(echo $TEMP | awk '{print int($1+0.5)}')
echo "$TEMP °C "
