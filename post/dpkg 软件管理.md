Date: 2015-05-10
Title: dpkg管理
Tags: linux
Author: xiah
Abstract: 本文讲述了linux 下dpkg包的管理，包括安装，更新，卸载等

#dpkg 软件管理

本文是在ubuntu14.10 64位操作系统下实验的，其它的linux系统类似。
在 GNU/Linux( 以下简称 Linux) 操作系统中，RPM 和 DPKG 为最常见的两类软件包管理工具，他们分别应用于基于 RPM 软件包的 Linux 发行版本和 DEB 软件包的 Linux 发行版本。软件包管理工具的作用是提供在操作系统中安装，升级，卸载需要的软件的方法，并提供对系统中所有软件状态信息的查询。
RPM 全称为 Redhat Package Manager，最早由 Red Hat 公司制定实施，随后被 GNU 开源操作系统接受并成为很多 Linux 系统 (RHEL) 的既定软件标准。与 RPM 进行竞争的是基于 Debian 操作系统 (UBUNTU) 的 DEB 软件包管理工具－ DPKG，全称为 Debian Package，功能方面与 RPM 相似。二者之具体比较不在本文范围之内。

##1.安装
```
sudo dkpk -i package.deb
```

##2.升级
```
sudo dpkg -i package.deb ( 和安装命令相同）
```

##3.卸载
```
sudo dpkg -r package.deb # 不卸载配置文件
sudo dpkg -P package.deb # 卸载配置文件
```

##４.查询 DEB 包中包含的文件列表命令
```
sudo dpkg-deb -c package.deb
```

##5.查询 DEB 包中包含的文件列表
```
dpkg --info package.deb
```

##6.查询系统中所有已安装 DEB 包
```
dpkg -l package
```


