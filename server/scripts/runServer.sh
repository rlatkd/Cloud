#!/bin/bash

cd      /home/ubuntu/ssgbay

echo    ">>> run app -------------------------------------------------------"

cron

python3 -u app.py > /dev/null 2> /dev/null < /dev/null &