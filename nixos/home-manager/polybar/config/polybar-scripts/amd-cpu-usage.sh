#!/bin/bash
USAGE=echo " $(grep 'cpu ' /proc/stat | awk '{cpu_usage=($2+$4)*100/($2+$4+$5)} | printf "%0.2f%", cpu_usage')
echo $USAGE
