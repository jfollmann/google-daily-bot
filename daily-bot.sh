#!/bin/env zsh
# Generate to random uuid to set THREAD_KEY in chat
THREAD_KEY=$(cat /proc/sys/kernel/random/uuid)

# SET a google incomming webhook URL
BOT_URL='[ENTER_HERE_THE_INCOMMING_WEBHOOK_FROM_GOOGLE]'

# Get chucknorris API to generate a random fact
# IMPORTANT: depends to JQ package (https://stedolan.github.io/jq/) to parse JSON response
CHUCK_MESSAGE=$(curl https://api.chucknorris.io/jokes/random\?category\=dev | jq -r '.value')

# Payload to send in webhook event
MESSAGE="{\"text\": \"Bom dia <users/all>\n\n*Bora pra <DAILY_URL|daily>?*\n\nPra alegrar o dia, segue um fato curioso sobre mim:\n- _${CHUCK_MESSAGE}_ 🥁 \n\nBom trabalho pessoal.👊\"}"

# Execute POST event to webhook
curl --request POST \
  --url "${BOT_URL}&thread_key=${THREAD_KEY}" \
  --header 'Content-Type: application/json' \
  --data "${MESSAGE}"
