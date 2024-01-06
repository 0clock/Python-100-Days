#!/bin/bash

ls=$(ls | grep "Day")

rm -r ./ConvertToHexo/file
mkdir ./ConvertToHexo/file

for ((i=1;i<=11;i++))
do
    dir=$(echo $ls | cut -d " " -f $i )
    mkdir ./ConvertToHexo/file/$dir/
    cd $dir
    allfile=$(ls *.md)
    lines=$(echo "$allfile" | wc -l)
    # 使用循环遍历每一行
    for ((j=1; j<=lines; j++)); 
    do
        srcFile=$(echo "$allfile" | sed -n "${j}p")
        ../ConvertToHexo/src/convert $srcFile 
        mv convert_temp.md ../ConvertToHexo/file/$dir/$srcFile
        # rm convert_temp.md
    done
    cd ..
done