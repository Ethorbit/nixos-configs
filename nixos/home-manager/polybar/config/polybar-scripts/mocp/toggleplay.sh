#!/bin/bash

cd $(dirname $0)
STATE=$(./state.sh)

case $STATE in
    STOP)
    echo ""
    ;;
    PAUSE)
    echo ">"
    ;;
    PLAY)
    echo "||"
    ;;
esac
