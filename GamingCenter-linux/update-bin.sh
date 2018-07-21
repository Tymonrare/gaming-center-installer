#!/bin/bash

mkdir -p bin

echo Update app files:
saveAs=cache

if [ -e $saveAs ]; then
	rm $saveAs
fi

if [ -e "./bin/platform-type" ]; then
	platform=`cat ./bin/platform-type`
else
	read -p 'Select your platform: ' platform
	echo $platform > ./bin/platform-type
fi
	

echo Downloading recent version for $platform..

python ./res/py/download-recent-bin.py https://d3i8w87ms3cidi.cloudfront.net bin/app/GamingCenter-$platform- $saveAs

if [ ! -e $saveAs ]; then
	echo "Download error. Check platform ($platform) name and try again"
	exit 1
fi

#backup
mkdir -p ./.backups
7z a -t7z ./.backups/$(date +"%F_%T").7z -r ./bin -mx=0

#delete old ini duples
find ./bin/ -name '*_1.ini' -delete

# Do not overwrite ini, copy rest
7z x $saveAs -aoa -xr!*.ini
7z x $saveAs -aou *.ini -r

rm $saveAs

chmod +x Launch
