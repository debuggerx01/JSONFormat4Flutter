#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   tools.py
# @Date     :   18-1-30 上午11:48
# @Author   :   DebuggerX

import json
from PyQt5.QtWidgets import QLabel, QComboBox, QMessageBox

# 验证json字符串是否合法
from code_top import get_top_code_list

from code_top import get_top_code_dict


def is_json(myjson):
    try:
        json.loads(myjson)
    except ValueError:
        return False
    return True


# 传入未格式化的单行json字符串，返回指定缩进的多行json字符串
def jformat(inp):
    obj = json.loads(inp)
    outp = json.dumps(obj, skipkeys=False, ensure_ascii=False, check_circular=True, allow_nan=True, cls=None, indent='  ', separators=None,
                      default=None, sort_keys=True)
    return outp


def generate_code(work_bean):
    level_bean = None
    for (l, f, t, n) in work_bean:
        if l == -1:
            if t.startswith('List<'):
                level_bean = []
            else:
                level_bean = {}

        level_bean
        # todo 怎么搞。。。


# l, f, t, n = work_bean.pop(0)
#
# if l == -1:
#     if t.startswith('List<'):
#         top = get_top_code_list(t, n)
#     else:
#         top = get_top_code_dict(t)
#     print(top)


def check_and_generate_code(bean):
    work_bean = []

    for f, t, n in bean:
        field_text = f.text()

        level = field_text.find('※') // 4
        field_text = field_text[field_text.find("》") + 1: field_text.find(":")] if ":" in field_text else ''
        type_text = t.currentText() if type(t) is QComboBox else t.toPlainText()
        name_text = n.text() if type(n) is QLabel else n.toPlainText()

        if type_text.strip() != '':
            work_bean.append([level, field_text, type_text, name_text])
        else:
            QMessageBox().information(f, "警告", "字段类型未设置", QMessageBox.Ok)
            return ''

    return generate_code(work_bean)
