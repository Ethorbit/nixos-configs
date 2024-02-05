#!/usr/bin/env bash
[ ! $(command -v nvidia-smi) ] && echo "" && exit
echo $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)%
