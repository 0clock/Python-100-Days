/*
 * Filename: main.c
 * Author: linus
 * Date: 2024-01-05
 * Version: 1.0
 *
 * Description: 将文档的前面加入以下内容：
---
layout: wiki  # 使用wiki布局模板
wiki: python # 这是项目名
title: # 文档标题
---

1.传入参数是要转换的文件名 xxx.md
2.转换出的临时文件名是 convert_temp.md
TODO:
3.要写入的字符串名字是
4.如何获得文章标题


5.使用shell脚本将临时文件移动出去
 */

#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <pthread.h>
#include <string.h>
#include <semaphore.h>


int main(int argc, const char *argv[])
{
    FILE *srcfp;
    FILE *destfp;

    char* oldtex;
    char* newtex;

    if ((srcfp = fopen(argv[1], "r")) == NULL)
    {
        perror("fopen error");
        return -1;
    }

    if ((destfp = fopen("convert_temp.md", "w")) == NULL)
    {
        perror("fopen error");
        return -1;
    }

    // 读取文件标题内容
    // 定义缓冲区和读取行的变量
    char buffer[256];
    char *line;
    char title[128];
    while (fgets(buffer, sizeof(buffer), srcfp) != NULL)
    {
        // 查找第一个出现的 "##"
        line = strstr(buffer, "##");

        

        // 如果找到了
        if (line != NULL)
        {
            // 找到"##"后面的内容
            line += 3; // 移动到 "##" 后的位置
            sprintf(title, "%s", line);
            // 去掉换行符
            if ((line = strchr(title, '\n')) != NULL)
            {
                *line = '\0';
                fseek(srcfp, line-buffer +1 , SEEK_SET);
            }
            break;
        }
    }

    // 写入Front Matter
    fprintf(destfp, "---\n");
    fprintf(destfp, "layout: wiki  # 使用wiki布局模板\n");
    fprintf(destfp, "wiki: python # 这是项目名\n");
    fprintf(destfp, "title: %s  # 文章标题\n", title);
    fprintf(destfp, "---\n");
    
    
    while (!feof(srcfp))
    {
        int res = fread(buffer, 1, sizeof(buffer), srcfp);
        fwrite(buffer, 1, res, destfp);
    }


    printf("%s 转换完成。\n", title);
    fclose(srcfp);
    fclose(destfp);
}
