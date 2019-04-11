#!/bin/bash
INPUT=entradas.csv
OLDIFS=$IFS
IFS=,
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
while read NAME DOMAIN IPADDR ZONE
do
echo "resource \"aws_route53_record\" \"$NAME-A\" {
    zone_id = \"$ZONE\"
    name    = \"$NAME.$DOMAIN\"
    type    = \"A\"
    records = [\"$IPADDR\"]
    ttl     = \"60\"

}" >> entradas-$DOMAIN.tf

done < $INPUT
IFS=$OLDIFS