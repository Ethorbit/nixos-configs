#!/bin/bash
DIR=$(dirname $0)
TEMP=$($DIR/nvidia-gpu-temperature.sh)
USAGE=$($DIR/nvidia-gpu-usage.sh)

echo "$USAGE $TEMP"
