#!/usr/sh
DATE=`date -Idate`
echo $DATE
sed -i""  "s/last_revised.*/last_revised: '$DATE'/g" metadata.yaml
