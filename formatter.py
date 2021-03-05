#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   formatter.py
# @Date     :   18-1-26 下午5:48
# @Author   :   DebuggerX
from functools import partial

from mainwindow import *
from tools import *
from check_version import *

# 第三方库 用于解决跨平台的复制粘贴和复制的文本带bom问题
import pyperclip

# 定义显示的json格式化字符串的缩进量为4个空格
indent = ' ' * 4

# 临时存储
last_list_com_box = None


def analyse_json_obj(json_obj, level=0, res=None, json_key=None):
    if res is None:
        res = []

    # 对字典对象的属性按照基本数据类型->list类型->dict类型的次序排序
    if isinstance(json_obj, dict):
        json_obj = sorted(
            json_obj.items(), key=lambda x:
            (
                isinstance(x[1], dict),
                isinstance(x[1], list),
                isinstance(x[1], str),
                isinstance(x[1], bool),
                isinstance(x[1], float),
                isinstance(x[1], int),
                x[0]
            )
        )

        # 插入父层级数据为dict类型，类型序号为8，层级深度+1，遍历解析所有子属性
        if json_key is None:
            res.append('%s<[dict]>8' % (indent * level))
        else:
            res.append('%s<%s> : <[dict]>8' % (indent * level, json_key))
        level += 1
        for key, value in json_obj:
            analyse_json_obj(value, level, res, key)

    elif isinstance(json_obj, list):
        # 插入父层级数据为list类型，类型序号为9，层级深度+1，并取其第一个元素继续解析
        if json_key is None:
            res.append('%s<[list]>9' % (indent * level))
        else:
            res.append('%s<%s> : <[list]>9' % (indent * level, json_key))
        if len(json_obj) > 0:
            json_obj_temp = json_obj[0]
            if len(list(filter(lambda item: type(item) is dict or item is None, json_obj))) == len(json_obj):
                for i in range(1, len(json_obj)):
                    for k in json_obj[i] if json_obj[i] is not None else {}:
                        if json_obj_temp is not None and (k not in json_obj_temp or json_obj_temp[k] is None):
                            json_obj_temp[k] = json_obj[i][k]
            json_obj_temp = None if json_obj_temp is {} else json_obj_temp
            analyse_json_obj(json_obj_temp, level + 1, res)

    else:
        # 针对基本数据类型，在插入的键值对数据后再加入类型序号标志位
        obj_type = type(json_obj)
        if obj_type is int:
            obj_type = 1
        elif obj_type is float:
            obj_type = 2
        elif obj_type is bool:
            obj_type = 3
        elif obj_type is str:
            obj_type = 4
        else:
            obj_type = 0
        res.append('%s<%s> : <%s>%d' % (indent * level, json_key, json_obj, obj_type))

    return res


def change_text(com_box, current_text):
    com_box.setCurrentText('List<%s>' % current_text)


def change_background_color(com_box, current_text):
    if current_text == '':
        com_box.setStyleSheet("background-color:rgb(220,20,60)")
    elif current_text == 'Object':
        com_box.setStyleSheet("background-color:rgb(255,246,143)")
    else:
        com_box.setStyleSheet("")


# 生成字段类型下拉框
def get_type_combobox(need_connect, line):
    com_box = QtWidgets.QComboBox()
    com_box.setEditable(True)
    obj_type = int(line[-1]) if line[-1].isdigit() else 0
    global last_list_com_box

    com_box.currentTextChanged.connect(partial(change_background_color, com_box))

    if need_connect and last_list_com_box is not None:
        com_box.currentTextChanged.connect(partial(change_text, last_list_com_box))
    last_list_com_box = None

    # 根据字段数据的最后一位数字标记指定下拉框默认类型
    if obj_type < 8:
        com_box.addItem('Object')
        com_box.addItem('int')
        com_box.addItem('double')
        com_box.addItem('bool')
        com_box.addItem('String')

        com_box.setCurrentIndex(obj_type)
    elif obj_type == 8:
        com_box.addItem('Map<String, dynamic>')
        com_box.setCurrentText('')
    elif obj_type == 9:
        com_box.setCurrentText('List<>')
        # 将该list字段的编辑框临时保存，用于与下一个字段的类型绑定
        last_list_com_box = com_box

    # 为text至不合法的输入框设置颜色
    change_background_color(com_box, com_box.currentText())
    return com_box


def get_name_text_edit(line):
    te = QtWidgets.QTextEdit(line[line.find('<') + 1:line.find('>')])

    return te


def update_list(json_str):
    json_obj = json.loads(json_str)
    # 传入json对象，返回所需要的格式化协议数据数组
    res = analyse_json_obj(json_obj)
    global last_list_com_box
    last_list_com_box = None
    ui.tv_fields.setRowCount(len(res))

    pre_type_combobox = None
    pre_index = -1
    ii = 0
    for i in range(len(res)):
        line = res[i]
        assert isinstance(line, str)
        index = line.find('<')
        temp_type_combobox = get_type_combobox(index != pre_index, line)
        pre_index = index
        ui.tv_fields.setCellWidget(ii, 1, temp_type_combobox)
        if temp_type_combobox.count() > 1 and pre_type_combobox is not None and pre_type_combobox.currentText().startswith('List'):
            ui.tv_fields.setRowCount(ui.tv_fields.rowCount() - 1)
            pre_type_combobox = temp_type_combobox
            continue
        pre_type_combobox = temp_type_combobox
        if line.strip() == '<[dict]>8':
            label = QtWidgets.QLabel("")
            label.setStyleSheet("background-color: rgb(200,200,200);")
            ui.tv_fields.setCellWidget(ii, 2, label)
        else:
            ui.tv_fields.setCellWidget(ii, 2, get_name_text_edit(line))

        if index == 0:
            field = line.replace('<', '').replace('>', '')
        else:
            field = ("%s※==》%s" % (' ' * (index - 4), line[index:])).replace('<', '').replace('>', '')

        label = QtWidgets.QLabel()
        label.setText(field[0:60] + '...' if len(field) > 60 else field[0:-1])
        label.setToolTip(field[0:-1])

        ui.tv_fields.setCellWidget(ii, 0, label)
        ii += 1

    ui.tv_fields.resizeColumnToContents(0)


def json_format():
    # 从文本编辑框获取json字符串
    json_str = ui.te_json.toPlainText()
    json_str = rm_invisible(json_str.strip())
    if is_json(json_str):
        # 将格式化后的json字符串覆盖到文本编辑框中
        ui.te_json.setText(jformat(json_str.replace('\n', '')))

        # 为了修复json中含有内容为空的对象，也就是有'{}'这种玩意时解析失败的问题，先预处理把'{}'全部替换成null
        # 根据json更新表格条目
        update_list(json_str.replace('{}', 'null'))

    else:
        msg = QtWidgets.QMessageBox()
        msg.information(ui.te_json, "警告", "JSON不合法", QtWidgets.QMessageBox.Ok)


def generate_bean():
    bean = []
    for i in range(ui.tv_fields.rowCount()):
        var_field = ui.tv_fields.cellWidget(i, 0)
        var_type = ui.tv_fields.cellWidget(i, 1)
        var_name = ui.tv_fields.cellWidget(i, 2)

        bean.append([var_field, var_type, var_name])

    try:
        res = check_and_generate_code(bean)
    except IndexError as e:
        print(e)
        QMessageBox().information(msg_box_ui, "警告", "发生错误", QMessageBox.Ok)
        return
    if res != '':
        ui.te_json.setText(rm_invisible(res.strip()))


def str_to_camel_case(text):
    try:
        arr = filter(None, text.split('_'))
        res = ''
        for i in arr:
            res = res + i[0].upper() + i[1:]
        return res[0].lower() + res[1:]
    except IndexError:
        return text


def convert_names_to_camel_case(index):
    if ui.tv_fields.horizontalHeaderItem(index).text() == 'Name(click to camelCase)':
        for i in range(ui.tv_fields.rowCount()):
            name_cell = ui.tv_fields.cellWidget(i, 2)
            if type(name_cell) is QtWidgets.QTextEdit:
                assert isinstance(name_cell, QtWidgets.QTextEdit)
                name_cell.setText(str_to_camel_case(name_cell.toPlainText()))


def init_event():
    # 绑定json解析按钮事件
    ui.btn_format.clicked.connect(json_format)
    ui.btn_generate.clicked.connect(generate_bean)
    ui.btn_copy.clicked.connect(copy_left_text)
    ui.tv_fields.horizontalHeader().sectionClicked.connect(convert_names_to_camel_case)


def copy_left_text():
    text = ui.te_json.toPlainText()
    pyperclip.copy(text)
    pass


# 设置表格基础样式
def init_table():
    # 设置表头，表头文字居中
    ui.tv_fields.setHorizontalHeaderLabels(['Fields', 'Types', 'Name(click to camelCase)'])
    ui.tv_fields.horizontalHeader().setDefaultAlignment(QtCore.Qt.AlignHCenter)
    # 表头自动平分宽度
    ui.tv_fields.horizontalHeader().setSectionResizeMode(QtWidgets.QHeaderView.Stretch)
    # 设置第一列为固定宽度，不参与平分
    ui.tv_fields.horizontalHeader().setSectionResizeMode(0, QtWidgets.QHeaderView.Fixed)
    ui.tv_fields.resizeColumnToContents(0)
    # 隐藏左侧垂直表头
    ui.tv_fields.verticalHeader().setVisible(False)


def init_view():
    init_table()


def custom_ui():
    init_view()
    init_event()


if __name__ == "__main__":
    import sys

    app = QtWidgets.QApplication(sys.argv)
    widget = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(widget)
    # 在生成代码的基础上再修改UI以及添加逻辑
    custom_ui()
    widget.show()
    code = check_version()
    widget.setWindowTitle(widget.windowTitle().replace('code', str(code) + '-nullsafety'))
    sys.exit(app.exec_())
