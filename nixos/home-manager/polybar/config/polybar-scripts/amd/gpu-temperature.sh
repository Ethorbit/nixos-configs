#!/usr/bin/env bash
[ ! $(command -v sensors) ] && echo "" && exit
TEMP=$(sensors -j amdgpu-pci-2500 2> /dev/null)
TEMP=$(echo $TEMP | jq '."amdgpu-pci-2500".edge.temp1_input')
echo "$TEMP ℃"
  
