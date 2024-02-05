#!/usr/bin/env bash
DIR=$(dirname $0)
TEMP=$($DIR/gpu-temperature.sh)
USAGE=$($DIR/gpu-usage.sh)

echo "$USAGE $TEMP"

