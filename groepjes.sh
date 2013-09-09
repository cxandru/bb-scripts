#! /bin/sh

USERLIST="${0%/*}/userlist"

if [ -z "$*" ]; then
	echo "Usage: groepjes.sh s[0-9]*/s[0-9]*.txt" >& 2
	exit 1
fi

if [ ! -e "$USERLIST" ]; then
	echo Cannot find "$USERLIST" file >& 2
	exit 1
fi

addid() {
	result=false
	echo "1a"
	for id in $TOID; do
		if [ "s${id}.txt" != "${file##*/}" ]; then
			grep "$id" "$USERLIST" | sed 's/\(.*\)\t\(.*\)@.*/Name: \2 (\1)/g'
			result=true
		fi
	done
	echo "."
	echo "wq"
	$result
}

for dir in "$@"; do
	file="${dir}/${dir##*/}.txt"
	if [ ! -e "$file" ]; then
		echo "$file" not found. >& 2
		exit 1
	fi

	# 1) select only id's specified by the response file
	# 2) select any studentnr's contained in the response file
	# 3) select any studentnr's in any submitted file

	#TOID=`sed -n '/Name:/s/.*\(s[0-9]\+\).*/\1/p' "$file"`
	#TOID=`grep -o '\<s\?[0-9]\{7\}\>' "$file" | tr -d 's' | sort -u`
	TOID=`grep -ohI '\<s\?[0-9]\{7\}\>' "${file%%/*}"/* | tr -d 's' | sort -u`
	for id in $TOID; do
		grep "$id" "$USERLIST" | cut -f1,2 | tr '\t\n' '  ' | sed 's/@[[:print:]]*\>//g'
	done | sed 's/[^0-9] \</&<with> /g'
	echo

	#continue
	ed=`addid` && echo "$ed" | ed -s "$file"
done
