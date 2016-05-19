#!/bin/bash

r=$(netstat -tulpn | grep 80 | grep nginx)

if [ "${r}" ]
 then
   echo "Nginx is listening on port 80"
 else
   echo "Nginx is not running on port 80"
fi
