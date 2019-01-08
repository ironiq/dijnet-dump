#!/bin/bash

xpath() {
	xmllint --html --xpath "$1" - 2>/dev/null
}

xmlfl=$1

kialldatum=$(cat ${xmlfl} | xpath '//kialldatum/text()' | sed -e 's@\.@@g')
fizhatarido=$(cat ${xmlfl} | xpath '//fizhatarido/text()' | sed -e 's@\.$@@')
sorszam=$(cat ${xmlfl} | xpath '//sorszam/text()' | sed -e 's@/@_@g; s@ @@g')
invparts=$(echo "${sorszam}" | grep -c '_')
prefix=''
[ ${invparts} -eq 1 ] && sorszam=$(echo "${sorszam}" | sed -e 's/\(.*\)_\(.*\)/\2/g') && prefix=$(cat ${xmlfl} | xpath '//sorszam/text()' | sed -e 's@\(.*\)/.*@\1_@g;')
TARGET="${prefix}${fizhatarido}_${sorszam}"

mkdir ${TARGET}
mv *${sorszam}.* ${TARGET}/

