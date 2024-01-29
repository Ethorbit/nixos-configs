#!/bin/bash
DIR=$(dirname $0)
TEMP=$($DIR/amd-gpu-temperature.sh)
USAGE=$($DIR/amd-gpu-usage.sh)

echo "$USAGE $TEMP"

