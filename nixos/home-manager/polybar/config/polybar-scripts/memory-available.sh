#!/usr/bin/env bash
free -h | awk '{ print $7 }' | awk 'NR==2 { print $1 }'
