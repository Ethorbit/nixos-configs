#!/usr/bin/env bash
DIR=$(dirname $0)
TEMP=$($DIR/cpu-temperature.sh)
USAGE=$($DIR/cpu-usage.sh)

echo "$TEMP$USAGE"
