#!/usr/bin/env bash
# Usage: Arg 1 is the dir containing the tutor dirs with names those in the `name` map. If not supplied, cwd is used
MYDIR="${0%/*}"

. $MYDIR/loadConfig.sh

wd=$1
[ -z $wd ] && wd=.
echo $wd
for tad in "$wd"/*
do
    ta=$(basename "$tad")
    if [ -z "${name[$ta]}" ]
    then
	echo "Error: Could not find $ta"
	continue
    fi
    fstring="Grade & Feedback by ${name[$ta]}"
    for ffile in "$tad"/*/feedback.txt
    do
	echo "Processing $ffile"
	#add \n if not al present
	sed -i -e '$a\' "$ffile"
	#be idempotent
	if [ "$(tail -n1 "$ffile")" ==  "$fstring" ];
	then echo "Skipped $ffile"; continue
	fi
	echo "$fstring" >> "$ffile"
    done
done
