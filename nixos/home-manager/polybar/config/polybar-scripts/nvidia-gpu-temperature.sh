#!/bin/bash
echo "$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)°C"
