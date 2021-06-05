#!/bin/bash
while true
do

bt=$(timeout 45 gatttool -b $1 --char-write-req --handle='0x0038' --value="0100" --listen)

if [ -z "$bt" ]
  then

    echo "The reading failed"

  else

    id=$(./randomgenerator.sh)
    timeNow=$(date +"%T")
    dateNow=$(date +"%Y-%m-%d")
    timestampNow="$dateNow $timeNow"

    temphexa=$(echo $bt | awk -F ' ' '{print $12$11}'| tr [:lower:] [:upper:] )
    humhexa=$(echo $bt | awk -F ' ' '{print $13}'| tr [:lower:] [:upper:])
    batthexa=$(echo $bt | awk -F ' ' '{print $15$14}'| tr [:lower:] [:upper:])

    temperature100=$(echo "ibase=16; $temphexa" | bc)
    battery1000=$(echo "ibase=16; $batthexa" |bc)

    temperature=$(echo "scale=2;$temperature100/100" | bc)
    humidity=$(echo "ibase=16; $humhexa" | bc)
    battery=$(echo "scale=3;$battery1000/1000" | bc)

    echo "Temperature: "$temperature
    echo "Humidity: "$humidity"%"
    echo "Battery voltage: "$battery
    echo "Timestamp: "$timestampNow
    echo "Measurement id: "$id

fi
done
