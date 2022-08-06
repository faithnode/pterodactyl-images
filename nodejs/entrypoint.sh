cd /home/container || exit 1

INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

node -v
printf "\n"

PARSED=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

printf "$PARSED"

eval ${PARSED}