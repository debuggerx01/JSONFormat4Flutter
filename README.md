# JSONFormat4Flutter
受zzz40500/GsonFormat启发，将JSONObject格式的String解析成dart语言的实体类

## 基本操作：

![](https://github.com/debuggerx01/JSONFormat4Flutter/blob/master/Example/json.gif?raw=true)


## 简易运行方式：
在 [Release](https://github.com/debuggerx01/JSONFormat4Flutter/releases) 页面中，选择下载对应平台最新的二进制文件后——
#### linux:
在程序目录打开终端后执行：sudo chmod u+x Formater_linux && ./Formater_linux
#### mac：
在程序目录打开终端后执行：sudo chmod u+x Formater_mac && ./Formater_mac
#### windows：
直接双击运行 Formater_win.exe
## 源码运行（以MAC为例）
没有python运行环境的用户需要先安装python

mac中可以使用如下命令安装
```
brew install python3
brew install pip3
```
pip3是python3的包管理工具

brew 可以参考下面的链接

https://brew.sh/index_zh-cn



运行库的时候会可能会提示
```
Traceback (most recent call last):
  File "formater.py", line 8, in <module>
    from mainwindow import *
  File "/Users/cjl/IdeaProjects/flutter/sxw-flutter-app/JSONFormat4Flutter/mainwindow.py", line 9, in <module>
    from PyQt5 import QtCore, QtGui, QtWidgets
ModuleNotFoundError: No module named 'PyQt5'

```

这时候可以直接用
`pip3 install PyQt5`
`pip3 install pyperclip`
等待安装完成

``（注：brew安装最新版python3可能会出现ssl模块丢失导致pip3无法正常使用，此时也可以考虑直接在python官网下载pkg包方式安装python）``

后面使用就是在命令行敲入
`python3 formater.py`

## 已知问题
+ mac下从文本框复制出的文字直接粘贴到 idea/android studio 中报错 " lllegal character '65279' "

参考 [issue1](https://github.com/debuggerx01/JSONFormat4Flutter/issues/1) ，如下图，使用5.7.1及之前版本的pyqt5

![](https://github.com/debuggerx01/JSONFormat4Flutter/blob/master/Example/pyqt571.png?raw=true)
