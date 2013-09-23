#!/bin/sh
#
# replace string patterns in files matching a fileglob pattern
#
file_patterns='\*.e
\*.ace
\*.h
\*.c
\*.y
\*.l'

echo "$file_patterns" | while read fp
do
	echo "DOING find . -name $fp -print"
	find . \( -name '.svn' -prune \) -o -name "$fp" -print | while read fn
	do
		if [ ! -f $fn.bak ]; then
			cp $fn $fn.bak
		fi
		echo "....DOING sed $fn.bak > $fn"
		sed -e 's/\"\$Source[^$]*\$\"/\"$URL: https://svn.origo.ethz.ch/abel/trunk/libraries/openehr/replace_strings.sh $\"/' \
		    -e 's/\"\$Revision[^$]*\$\"/\"$LastChangedRevision$\"/' \
		    -e 's/\"\$Date[^$]*\$\"/\"$LastChangedDate$\"/' $fn.bak > $fn
	done
done
