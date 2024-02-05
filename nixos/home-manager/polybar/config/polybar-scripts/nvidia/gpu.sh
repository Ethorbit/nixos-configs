#!/usr/bin/env bash
[ ! $(command -v nvidia-smi) ] && echo "" && exit

DIR=$(dirname $0)
TEMP=$($DIR/gpu-temperature.sh)
USAGE=$($DIR/gpu-usage.sh)

echo "$USAGE $TEMP"
