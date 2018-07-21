#!/bin/bash

mkdir -p bin

# Find type
if [ -e "./bin/showroom-type" ]; then
	type=`cat ./bin/showroom-type`
else
	read -p 'Enter showroom type (xd-default for example): ' type
fi

if [ -z $type ]; then
	echo Empty input: Skip install
	exit 0
fi

if [ "$type" == "none" ]; then
	echo "None" type input: Skip install.
	echo $type > ./bin/showroom-type
	exit 0
fi

echo Update showroom files:

# begin download
saveAs=cache

if [ -e $saveAs ]; then
	rm $saveAs
fi

echo Downloading recent version of $type..

python ./res/py/download-recent-bin.py https://d3i8w87ms3cidi.cloudfront.net bin/showrooms/$type- $saveAs

if [ ! -e $saveAs ]; then
	echo "Download error. Check type ($type) name and try again"
	exit 1
fi

7z x $saveAs -aoa -r -o./bin/showroom

rm $saveAs

echo $type > ./bin/showroom-type
