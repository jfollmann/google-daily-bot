#!/bin/bash
# Generate to random uuid to set THREAD_KEY in chat
THREAD_KEY=$(cat /proc/sys/kernel/random/uuid)

# SET a google incomming webhook URL
BOT_URL='[ENTER_HERE_THE_INCOMMING_WEBHOOK_FROM_GOOGLE]'

# Get chucknorris API to generate a random fact
# IMPORTANT: depends to JQ package (https://stedolan.github.io/jq/) to parse JSON response
CHUCK_MESSAGE=$(curl https://api.chucknorris.io/jokes/random\?category\=dev | jq -r '.value')

# Payload to send in webhook event
MESSAGE="{\"text\": \"Bom dia <users/all>

*Bora pra <https://DAILY_URL|daily>?*

Pra alegrar o dia, segue um fato curioso sobre mim:
- _${CHUCK_MESSAGE}_ 🥁 

Bom trabalho pessoal.👊
_Quer saber como isso funciona? <https://github.com/jfollmann/google-daily-bot|acesse o repo.>_\"}"

# Execute POST event to webhook
curl --request POST \
  --url "${BOT_URL}&thread_key=${THREAD_KEY}" \
  --header 'Content-Type: application/json' \
  --data "${MESSAGE}"
