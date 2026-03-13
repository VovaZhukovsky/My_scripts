#!/bin/bash


# Скрипт оповерщает о входе по ssh на сервере и выходе через телеграм-бота
# Для реализации нужно добавить строчку session optional pam_exec.so /usr/local/bin/login_notify.sh
# в Pluggable Authentication Modules (PAM) ( /etc/pam.d/sshd ) конфиг на сервере

TELEGRAM_TOKEN="token"
CHAT_ID="12345678"

USER="$PAM_USER"
IP="$PAM_RHOST"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

if [ "$PAM_TYPE" = "open_session" ]; then
    MESSAGE="🚀 User $USER logged IN from $IP at $DATE"
elif [ "$PAM_TYPE" = "close_session" ]; then
    MESSAGE="🔒 User $USER logged OUT from $IP at $DATE"
else
    exit 0
fi

curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$MESSAGE"