#!/bin/bash


no=1
while [ $no -le 23 ]
 do
	wget -a Foto.log -nv  https://loremflickr.com/320/240/kitten
	no=$((no+1))
 done

md5sum * | sort | awk 'BEGIN{hash = ""} $1 == hash {print $2} {hash = $1}' | xargs rm

s=1
for file in *
do
	if [[ $file == *"kitten"* ]]
	then
		namafile=`printf "Koleksi_%02d.jpg" $s`
		mv $file $namafile
		s=$((s+1))
	fi
done
