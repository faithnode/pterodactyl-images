#!/bin/bash

cd /home/container || exit 1

RESET="\033[0m"
YELLOW="\033[33m\033[1m"

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

dotnet --version
echo -e '\n'

STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

echo -e "${YELLOW}Executing command:${RESET} ${STARTUP}\n"

eval "${STARTUP}"