#!/bin/sh
echo $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)%
