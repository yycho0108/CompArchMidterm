#!/bin/bash
if [ "$#" -ne 0 ]; then
	file=$1;
	if [ -f "$file" ]; then
		guard=$(echo __$(echo ${file^^} | tr . _)__ );
		echo -e "\`ifndef $guard\n\`define $guard\n$(cat $file)\n\`endif" > $file
	else
		echo "NOT A FILE"
	fi
else
	echo "Apply Guard to All Files in Directory? [y/N]"
	read yes
	if [ "$yes" = "y" ]; then
		for file in *.v; do
			guard=$(echo __$(echo ${file^^} | tr . _)__ );
			cho -e "\`ifndef $guard\n\`define $guard\n$(cat $file)\n\`endif" > $file
		done
	fi
fi
