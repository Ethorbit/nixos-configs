#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
#echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
#polybar main 2>&1 | tee -a /tmp/polybar1.log & disown

ITER=0
for monitor in $(polybar --list-monitors | cut -d":" -f1); do
    if [ $ITER -ne 0 ]; then  # Primary (which shows first) uses main, so we skip it.'      
            BAR="notmain"
    else
        BAR="main"  
    fi

    MONITOR=$monitor polybar --reload $BAR &
    echo "Ran $BAR on $monitor";

    ((ITER++))
done

echo "Bars launched..."
