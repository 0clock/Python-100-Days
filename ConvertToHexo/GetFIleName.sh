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