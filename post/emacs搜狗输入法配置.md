Date: 2015-04-21
Title: Emacs搜狗输入法配置
Tag: Emacs
Author: xiah
Abstract:　介绍了Emacs中使用搜狗输入法

#Emacs搜狗输入法配置
本文是在ubuntu14.04环境下完成，其它版本类似
*从命令行启动Emacs
```shell
LC_CTYPE='zh_CN.UTF-8' emacs
```

*从Dash启动Emacs
```shell
sudo mv /usr/bin/emacs24-x /usr/bin/emacs24-x_original
```

*创建脚本
```shell
echo "LC_CTYPE='zh_CN.UTF-8' emacs24-x_original" | sudo tee /usr/bin/emacs24-x
sudo chmod a+x /usr/bin/emacs24-x
```

原文来自互联网，[参考](http://heartnheart.github.io/blog/2015/01/15/SogouIME_on_English_Ubuntu_14.04/)
