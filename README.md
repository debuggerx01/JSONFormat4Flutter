# JSONFormat4Flutter
受zzz40500/GsonFormat启发，将JSONObject格式的String解析成dart语言的实体类

## 详细介绍说明(掘金)：[在Flutter开发过程中快速生成json解析模板类的工具](https://juejin.im/post/5b4e04bbe51d45198c018e6e)

## 使用演示操作：

![](https://github.com/debuggerx01/JSONFormat4Flutter/blob/master/Example/json.gif?raw=true)


## 使用说明
#### 1.界面操作 (参考录屏：[parse.gif](https://github.com/debuggerx01/JSONFormat4Flutter/blob/master/Example/parse.gif))
1. 工具运行以后，先将复制好的json字符串粘贴到左侧文本框，然后点击'格式化'按钮；如果提示出错请检查json是否合法
2. 格式化成功后左侧json将会按照缩进格式化显示，并且右侧表格将显示分析得出的json结构，'Fields'列显示层级和原始分析数据，'Name'列显示每个字段的名称，'Type'列用于设定字段的数据类型
    1. 对于普通数据类型(int、 double、 boolean、 String)，Types列的类型将会自动给出，请尽量避免在上面滚动鼠标滚轮导致类型选择改变
    2. 对于值null的字段，Types列的类型会自动设置为Object，并以黄色背景作为警告。此时如果直接生成代码也是可以使用的，只是该字段在使用时可能需要手动强转，所以建议在知晓该字段实际类型情况下尽量补全json字符串后再点击'格式化'，或者在类型下拉框中指定实际的基本数据类型
    3. 对于自定义对象类型(或者说字典/Map)，'Fields'的对应输入框将留空并设为红色背景，需要您手动输入类型名称，并请注意：
        1. 任意一个字段没有输入类型名时点击代码生成按钮，都将弹出警告提示并拒绝生成代码
        2. 设置类型名时可以参考同一行'Name'栏的值进行设置以方便使用时识别字段，一般情况下推荐直接将'Name'栏内容首字母大写作为类型名
        3. 但是需要注意，类型名不可与'Name'栏内容完全相同，且不能是dart中的关键字，否则生成的代码将包含语法错误
        4. 一般情况下第一行的数据类型为对象且'Name'栏内容为空，设置第一列的'Types'即为生成的bean的顶级对象类名，推荐使用'该json的作用+Resp/Bean'形式进行命名以方便管理
    4. 对于数组类型，'Types'栏将被自动设置，并且：
        1. 数组的泛型类型取决于数组的内容的类型，也就是下一行设置的类型；当数组下一行的内容类型变化时泛型也会自动改变
        2. 支持数组的嵌套泛型传递
        3. 支持空数组，并且生成的代码中其泛型会被设置为dynamic
    5. 特殊的，如果json本身的顶层级不是对象而是数组，那么需要为第一行的'Name'栏设置类型名称，获取顶层级数组数据的方式为对象bean.list
3. 确认设置无误后，点击'生成Bean'按钮，左侧json显示栏的内容将被替换为生成的代码，可以使用鼠标键盘全选复制，或者直接点击下方的'复制'按钮，然后将代码粘贴到IDE中，完成解析流程


#### 2.生成代码说明  (参考录屏：[use.gif](https://github.com/debuggerx01/JSONFormat4Flutter/blob/master/Example/use.gif))

1. 反序列化(json字符串->对象)
<br>将生成的代码粘贴到dart源文件中后，即可以在任意地方导包使用，一般方法为(以http.get请求为例):
    ```java
    var response = await HTTP.get(url);
    var resp = BeanResp(response.body);
    ```
    也就是说，将请求到的json内容作为参数传递给BeanResp的默认构造函数，这样生成的resp对象即是请求到内容的实体。
    需要说明的是，默认构造既可以传入json的原始字符串，也可以传入已经用原生json.decode()方法解析过的json对象(这主要是为了照顾使用dio库进行数据请求时结果数据会被自动解析成json对象的情况)。
    只有顶级对象拥有默认构造方法，而其他子层级对象将使用xxx.fromJson()的命名构造进行对象创建。

2. 序列化(对象->json字符串)
<br>与官方样例的处理方式不同，直接调用对象的toString()方法即可得到json字符串完成序列化操作

3. 手动创建对象
<br>为了方便大部分使用场景下的便利性，bean的默认构造函数被用来实现反序列化，所以如果想要在代码中手动传参创建bean对象，可以使用xxx.fromParams()命名构造来完成。

## 简易运行方式：
在 [Release](https://github.com/debuggerx01/JSONFormat4Flutter/releases) 页面中，选择下载对应平台最新的二进制文件后——
#### linux:
在程序目录打开终端后执行：chmod u+x Formatter_linux && ./Formatter_linux
#### mac：
在程序目录打开终端后执行：chmod u+x Formatter_mac && ./Formatter_mac
#### windows：
直接双击运行 Formatter_win.exe
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
`python3 formatter.py`

## 已知问题
+ mac下从文本框复制出的文字直接粘贴到 idea/android studio 中报错 " lllegal character '65279' "

参考 [issue1](https://github.com/debuggerx01/JSONFormat4Flutter/issues/1) ，如下图，使用5.7.1及之前版本的pyqt5

![](https://user-gold-cdn.xitu.io/2018/7/17/164a8c24460f41ee?w=1270&h=861&f=png&s=174844)
