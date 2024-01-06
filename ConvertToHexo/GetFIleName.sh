# toc:
#   'Day01-15':
#     - Day01-15/01.初识Python
    # - Day01-15/01.初识Python.md
#     - Day01-15/02.语言元素

#!/bin/bash

ls=$(ls | grep "Day")

echo "ls=$ls"
for ((i=1;i<=11;i++))
do
    dir=$(echo $ls | cut -d " " -f $i )
    cd $dir
    file=$(ls *.md)
    indented_text=$(echo "$file" | sed 's/^/\//'| sed 's/^/    - '$dir'/' | sed 's/...$//')
    echo "  '"$dir"'":
    echo "$indented_text"
    cd ..
done

# 获取番外篇

cd 番外篇
dir=番外篇
file=$(ls *.md)
indented_text=$(echo "$file" | sed 's/^/\//'| sed 's/^/    - '$dir'/' | sed 's/...$//')
    echo "  '"$dir"'":
    echo "$indented_text"
    cd ..
# 获取公开课文件夹

cd ./公开课/文档
dir=公开课

file=$(ls *|grep .md)
indented_text=$(echo "$file" | sed 's/^/\//'| sed 's/^/    - '$dir'/' | sed 's/...$//')
echo "  '"公开课"'":
echo "$indented_text"