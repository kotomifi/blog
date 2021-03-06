Date: 2015-04-22
Title: Linux正则表达式——grep
Tag: linux, grep
Author: xiah
Abstract: Linux下grep命令使用总结

#正则表达式 grep的使用
在linux下经常需要在某个目录下查找某个文件，或者是在指定文件或者目录中查找知道哪个的内容。这些查找操作使用grep命令可以轻松完成。

**grep的常用选项**
***

* -c        只输出匹配的行数，不输出内容
* -i        不区分大小写
* -h        查询多文件时，不显示文件名
* -n        显示匹配行及行号
* -s        不显示不存在或者无匹配文本的错误信息
* -v        显示不包含匹配文本的所有行
* -r        递归查找
* -l        仅显示文件名
* -w        搜索整个单词，而不是单词中的一部分
* -E        允许使用扩展匹配模式           



**在单个文件内查找字符串**
***
```shell
grep [-i] str file_path
```
其中str是需要查找的字符串，如果字符串中有空格，用"(引号)包裹起来，file_path指定查找的文件。
eg:
```shell
grep -i hello ~/hello.txt
```
如果在hello.txt文件中查找到，会输出匹配到的一整行


**在多个文件中查找字符串**
***
```shell
grep [-l] hello file_path
```
-l是递归查找，hello是需要查找的字符串，file_path是一个目录名称，

**使用正则表达式**
***
```shell
grep he*o ~/hello.txt
```
上面的例示是在 hello.txt文件中查找 he开头o结尾的字符串
常用的正则表达式如下:

* '?'  最多匹配一次（0,1）
* '*'  匹配0或者多次
* '+'  匹配一次或者多次
* {n}  匹配n次
* {,m}  最多匹配m次
* {n,m} 匹配n到m次

**与其它命令组合使用**
***
```shell
ls -a | grep hello
```
上面的命令使用管道符号，在ls -a 输出的结构中查找 hello
