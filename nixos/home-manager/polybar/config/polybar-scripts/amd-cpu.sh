#!/bin/bash
DIR=$(dirname $0)
TEMP=$($DIR/amd-cpu-temperature.sh)
USAGE=$($DIR/amd-cpu-usage.sh)

echo "$TEMP $USAGE"

