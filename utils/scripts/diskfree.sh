#!/bin/bash

usage=$(df -hl | grep 'nvme0n1p2' | awk 'NR==1 {print $5}')
model=$(lsblk -d -no MODEL /dev/nvme0n1)
echo "{\"text\": \"🖴  $usage\", \"tooltip\": \"$model\"}"
