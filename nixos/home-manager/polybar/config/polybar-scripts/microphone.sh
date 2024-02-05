#!/usr/bin/env bash
if [[ $(~/.local/bin/pa-toggle-mic.sh --muted) -eq 0 ]]; then 
    echo -e "Mic:  🔊";
else
    echo -e "Mic:  🔇";
fi  
