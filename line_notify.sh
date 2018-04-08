#!/bin/bash

# Author: @kenzo0107
# LINE Notify Token - Media > "Send to".
TOKEN="$1"

# {ALERT.SUBJECT}
subject="$2"

# {ALERT.MESSAGE}
message="$3"

# zabbix parameters.
host=$(echo "${message}" | grep 'HOST:' | awk -F'HOST: ' '{print $2}' | sed -e "s/ $//")
datetime=$(echo "${message}" | grep 'DATETIME:' | awk -F'DATETIME: ' '{print $2}' | sed -e "s/ $//")
trigger_name=$(echo "${message}" | grep 'TRIGGER_NAME:' | awk -F'TRIGGER_NAME: ' '{print $2}' | sed -e "s/ $//")
trigger_status=$(echo "${message}" | grep 'TRIGGER_STATUS:' | awk -F'TRIGGER_STATUS: ' '{print $2}' | sed -e "s/ $//")
trigger_severity=$(echo "${message}" | grep 'TRIGGER_SEVERITY:' | awk -F'TRIGGER_SEVERITY: ' '{print $2}' | sed -e "s/ $//")
trigger_url=$(echo "${message}" | grep 'TRIGGER_URL:' | awk -F'TRIGGER_URL: ' '{print $2}' | sed -e "s/ $//")
item_name=$(echo "${message}" | grep 'ITEM_NAME:' | awk -F'ITEM_NAME: ' '{print $2}' | sed -e "s/ $//")
item_key=$(echo "${message}" | grep 'ITEM_KEY:' | awk -F'ITEM_KEY: ' '{print $2}' | sed -e "s/ $//")
item_value=$(echo "${message}" | grep 'ITEM_VALUE:' | awk -F'ITEM_VALUE: ' '{print $2}' | sed -e "s/ $//")
event_id=$(echo "${message}" | grep 'EVENT_ID:' | awk -F'EVENT_ID: ' '{print $2}' | sed -e "s/ $//")
item_id=$(echo "${message}" | grep 'ITEM_ID:' | awk -F'ITEM_ID: ' '{print $2}' | sed -e "s/ $//")

# Line Notify notice message.
notice="
${subject}
[Nome do Host] ${host}
[Horário] ${datetime}
[Status da Trigger] ${trigger_status}
${item_name}: ${item_value}"

curl https://notify-api.line.me/api/notify -H "Authorization: Bearer ${TOKEN}" -d "message=${notice}"
