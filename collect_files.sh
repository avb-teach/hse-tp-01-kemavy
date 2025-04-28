#!/bin/bash
input_dir="$1"
output_dir="$2"
max_depth=0
if [ "$3" == "--max_depth" ];
	then max_depth="$4"
fi
func() {
	cur="$1"
	cur_depth="$2"

	if [ "$max_depth" -ge "$cur_depth" ] && [ "$max_depth" -ne 0 ];
		then return
	fi
	for file in "$cur"/*;
		do if [ -f  "$file" ];
			then  init_name=$(basename "$file")
			final_name="$init_name"
			count=1
			while  [ -f "$output_dir/$final_name" ];
				do final_name="${init_name%.*}_$count.${init_name##*.}"
				count=$((count + 1))
			done
			cp "$file" "$output_dir/$final_name"
		elif [ -d "$file" ];
			then func "$file" $((cur_depth + 1)) 
		fi
	done
}

func "$input_dir" 0
