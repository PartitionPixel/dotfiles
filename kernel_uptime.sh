#!/bin/bash

kernel=$(uname -r)
uptime=$(uptime -p | sed 's/up //')

echo "{\"text\": \"❤ $kernel\", \"tooltip\": \"Uptime: $uptime\"}"
