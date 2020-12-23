#!/bin/bash

filename='benchmarktimes.txt'
n=1
while read line; do
# reading each line
if [ $n -eq 1 ]
then
    bt_start=$line
fi

if [ $n -eq 2 ]
then
    bt_end=$line
fi

n=$((n+1))
done < $filename

bt_totaltime=`expr $bt_end - $bt_start`

echo $bt_totaltime