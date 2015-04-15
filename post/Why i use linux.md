Date: 2015-04-15
Title: 我为什么喜欢Linux
Tags: linux
Author: xiah
Abstract: 使用linux的好处

#为什么使用linux

Linux下最好用的工具就是terminal，也就是命令行工具，平时我们大部分工作都是使用terminal完成的，
而Windows则正好相反，操作都是GUI。虽然GUI的封装让很多功能通过点点鼠标就能完成，但是你也只能
完成GUI封装的工作。

例如我在反编译一个Android　APK后想知道哪个文件里有　"DrawerLayout"这个字符串，在Linux下只用
一行命令就可以搞定：
eg:

    #!shell
    grep -ril DrawerLayout ~/Downloads

效果图如下，grep是一个查找命令，　参数　i：忽略大小写，　r: 递归查找，　l: 仅显示文件名，
后面的 ~/Downloads　是查找路径。是不是很方便。
![grep](../../../blog/img/grep.png)
