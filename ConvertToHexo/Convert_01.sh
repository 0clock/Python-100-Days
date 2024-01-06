#!/bin/bash

rm -r ./ConvertToHexo/file
mkdir ./ConvertToHexo/file


# 转换公开课
dir=公开课
mkdir ./ConvertToHexo/file/$dir/
mkdir ./ConvertToHexo/file/$dir/res
cd $dir/文档


alldir=$(ls -l | grep '^d' | awk '{print $9}')
dircount=$(echo "$alldir" | wc -l)
for ((i=1; i<=dircount; i++)); 
do
    nowdir=$(echo "$alldir" | sed -n "${i}p")
    cd $nowdir
    cp -r ./res ../../../ConvertToHexo/file/$dir/
    allfile=$(ls * | grep .md)
    lines=$(echo "$allfile" | wc -l)
    # 使用循环遍历每一行
    for ((j=1; j<=lines; j++)); 
    do
        srcFile=$(echo "$allfile" | sed -n "${j}p")
        ../../../ConvertToHexo/src/convert "$srcFile" 
        mv convert_temp.md ../../../ConvertToHexo/file/$dir/"$srcFile"
        # rm convert_temp.md
    done
    cd ..
done
cd ../../



# 转换Day中的
ls=$(ls | grep "Day")

for ((i=1;i<=11;i++))
do
    dir=$(echo $ls | cut -d " " -f $i )
    mkdir ./ConvertToHexo/file/$dir/
    cd $dir
    cp -r ./res ../ConvertToHexo/file/$dir/res
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

# 转换番外篇
dir=番外篇
mkdir ./ConvertToHexo/file/$dir/
cd $dir
cp -r ./res ../ConvertToHexo/file/$dir/res
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

