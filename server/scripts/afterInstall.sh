#!/bin/bash

cd      /home/ubuntu/ssgbay

echo    ">>> make static directory for upload images -----------------------"
mkdir   resources

echo    ">>> pip install ---------------------------------------------------"
pip     install -r requirements.txt

echo    ">>> cron settings -------------------------------------------------"
crontab -l | { cat; echo "* * * * * /usr/bin/python3 /home/ubuntu/ssgbay/historyUpdate.py >> /var/log/cron.log 2>&1"; } | crontab -

echo     ">>> npm install --------------------------------------------------"
npm     install
npm     run build

echo    ">>> remove template files -----------------------------------------"
rm      -rf  appspec.yml requirements.txt

echo    ">>> change owner to ubuntu ----------------------------------------"
chown   -R ubuntu /home/ubuntu/ssgbay