#!/usr/sh
DATE=`date -I date`
echo $DATE
sed -i ""  "s/last_revised.*/last_revised: '$DATE'/g" metadata.yaml
