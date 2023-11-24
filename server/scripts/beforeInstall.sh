#!/bin/bash

var=$(ps -ef | grep 'python3 -u app.py' | grep -v 'grep')
pid=$(echo ${var} | cut -d " " -f2)
if [ -n "${pid}" ]
then 
   kill -9 ${pid}
   echo ${pid} is terminated.
else
   echo ${pid} is not running.
fi

rm -rf /home/ubuntu/ssgbay
mkdir  /home/ubuntu/ssgbay