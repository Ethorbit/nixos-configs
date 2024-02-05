#!/usr/bin/env bash
[ ! $(command -v nvidia-smi) ] && echo "" && exit
echo "$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)°C"
