# JSONFormat4Flutter
受zzz40500/GsonFormat启发，将JSONObject格式的String解析成dart语言的实体类

用法：
![](https://github.com/debuggerx01/JSONFormat4Flutter/blob/master/Example/json.gif?raw=true)

## 友情提示
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

这时候可以直接用`pip3 install PyQt5`
等待安装完成

后面使用就是在命令行敲入
`python3 formater.py`
