#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   formater.py
# @Date     :   18-1-26 下午5:48
# @Author   :   DebuggerX

from mainwindow import *
import json


def is_json(myjson):
    try:
        json.loads(myjson)
    except ValueError:
        return False
    return True


def jformat(inp):
    obj = json.loads(inp)
    outp = json.dumps(obj, skipkeys=False, ensure_ascii=False, check_circular=True, allow_nan=True, cls=None, indent='  ', separators=None,
                      default=None, sort_keys=True)
    return outp


def json_format():
    json_str = ui.te_json.toPlainText()
    if is_json(json_str):
        ui.te_json.setText(jformat(json_str.replace('\n', '')))
    else:
        msg = QtWidgets.QMessageBox()
        msg.information(ui.te_json, "警告", "JSON不合法", QtWidgets.QMessageBox.Ok)


def customUI():
    ui.te_json.format = json_format
    ui.btn_format.clicked.connect(ui.te_json.format)


if __name__ == "__main__":
    import sys

    app = QtWidgets.QApplication(sys.argv)
    widget = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(widget)
    # 在生成代码的基础上再修改UI以及添加逻辑
    customUI()
    widget.show()
    sys.exit(app.exec_())
