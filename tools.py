#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   tools.py
# @Date     :   18-1-30 上午11:48
# @Author   :   DebuggerX

import json
from PyQt5.QtWidgets import QLabel, QComboBox, QMessageBox

# 验证json字符串是否合法
from template_code import get_top_code_dict, get_list_code_loop

msg_box_ui = None


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


def check_level_type(t):
    if t in ('int', 'double', 'bool', 'Object'):
        # 普通数据类型
        return 1
    if t == 'String':
        # 字符串类型
        return 2
    if t.startswith('List<'):
        # 数组类型
        return 3
    # 字典类型
    return 4


def list_code_loop(code, count, total, n, ct):
    list_count = 'List<' * (total - count)
    ab_count = '>' * (total - count)

    current_child = 'Child' * count
    child_child = 'Child' * (count + 1)

    current_items = 'Item' * (count + 1)
    parent_items = 'Item' * count

    fragment = get_list_code_loop(list_count, ct, ab_count, n, current_child, child_child, current_items, parent_items)

    if code == '':
        return fragment
    else:
        return code.replace('${loop}', fragment)


# 向代码模板中插入变量
def build_list_construction(f, t, n):
    class_type = t.replace('List<', '').replace('>', '')

    list_loop = '[];\n'
    assert isinstance(t, str)

    code = ''

    total = t.count('>')
    for i in range(total):
        code = list_code_loop(code, i, total, n, class_type)

    # 嵌套模板的后续处理
    code = code.replace('%s%s' % (n, 'Child' * total), 'new %s(%s%s)' % (class_type, n, ('Item' * total)))
    code = code[code.find(';') + 1:]
    code = code.replace('%s){' % n, 'jsonRes[\'%s\']){' % n).replace('${loop}', '')

    return list_loop + code


def add_param_to_code(code, param):
    (f, t, n) = param

    # 先按照基本数据类型方式处理
    properties = '  %s %s;\n' % (t, n)
    construction = '    %s = jsonRes[\'%s\'];\n' % (n, f)
    toString = '"%s": $%s,' % (f, n)

    pp = code.find('${properties}')
    code = code[:pp] + properties + code[pp:]

    pc = code.find('${construction}')
    code = code[:pc] + construction + code[pc:]

    ps = code.find('${toString}')
    code = code[:ps] + toString + code[ps:]

    # 字符串类型处理,只需要修改toString中的输出方式

    tcode = check_level_type(t)

    if tcode == 2:
        code = code.replace(': $%s' % n, ': ${%s != null?\'${JSON.encode(%s)}\':\'null\'}' % (n, n))

    # dict类型处理，只需要修改construction中的输出方式
    elif tcode == 4:
        code = code.replace('jsonRes[\'%s\']' % f, 'new %s(jsonRes[\'%s\'])' % (t, f))

    # list类型处理，只需要修改construction中的输出方式
    elif tcode == 3:
        list_loop = build_list_construction(f, t, n)

        code = code.replace('jsonRes[\'%s\'];' % f, list_loop)

    return code


# 用来存储各个code片段，最后合并就是完整的代码
codes = []


def build_level_code(level_bean):
    (l, f, t, n) = level_bean.pop(0)
    type_code = check_level_type(t)
    # 处理字典的子数据
    if type_code == 4:
        code = get_top_code_dict(t)
        work_level = level_bean[0][0]
        while len(level_bean) > 0:
            (l, f, t, n) = level_bean.pop(0)
            # 数据类型为字典时
            if check_level_type(t) == 4:
                # 先把该字典的定义作为顶层存到递归调用的bean顶部
                child_bean = [(l, f, t, n)]
                while len(level_bean) > 0 and level_bean[0][0] > work_level:
                    child_bean.append(level_bean.pop(0))
                build_level_code(child_bean)
            # 数据类型为数组时
            if check_level_type(t) == 3:
                generic_type = level_bean[0][2].replace('List<', '').replace('>', '')
                # 如果List的里层数据为dict则对其去壳后处理
                if check_level_type(generic_type) == 4:
                    while check_level_type(level_bean[0][2]) == 3:
                        work_level = level_bean[0][0]
                        level_bean.pop(0)

                    child_bean = []
                    while len(level_bean) > 0 and level_bean[0][0] > work_level:
                        child_bean.append(level_bean.pop(0))
                    build_level_code(child_bean)

            # 不管如何，到这里的数据都是目前dict的一级子数据，作为参数传入模板中
            code = add_param_to_code(code, (f, t, n))
        codes.append(code.replace(',${toString}', '').replace('${construction}', '').replace('${properties}', ''))


def generate_code(work_bean):
    is_list_top = False

    # 如果顶级容器为list而不是dict，则先在外面包一层dict，并将list的别名传递为dict的类型，list则重命名为'list'，并修改标志位供后面修改使用
    (l, f, t, n) = work_bean[0]
    if t.startswith('List<'):
        work_bean[0][3] = 'list'
        work_bean[0][1] = 'json_list'
        work_bean.insert(0, (-2, "", n, ""))
        is_list_top = True

    build_level_code(work_bean)

    res = ''
    codes.reverse()

    for c in codes:
        res += c

    codes.clear()

    # 如果顶级容器为list,需要修改第一次获取JSON对象的方式为直接获取
    if is_list_top:
        res = res.replace('jsonRes[\'list\']', 'jsonRes', 1)

    # 最终修改，添加jsonStr解析为jsonRes代码
    bp = res.find('(jsonRes) {')
    return 'import \'dart:convert\';\n' + res[:bp] + '(jsonStr) {\n  var jsonRes = JSON.decode(jsonStr);\n' + res[bp + 11:]


def check_and_generate_code(bean):
    work_bean = []
    global msg_box_ui
    msg_box_ui = bean[0][1]

    for f, t, n in bean:
        field_text = f.text()

        level = field_text.find('※') // 4
        field_text = field_text[field_text.find("》") + 1: field_text.find(":") - 1] if ":" in field_text else ''
        type_text = t.currentText() if type(t) is QComboBox else t.toPlainText()
        name_text = n.text() if type(n) is QLabel else n.toPlainText()

        if type_text.strip() != '':
            work_bean.append([level, field_text, type_text, name_text])
        else:
            QMessageBox().information(msg_box_ui, "警告", "字段类型未设置", QMessageBox.Ok)
            return ''

    (l, f, t, n) = work_bean[0]
    if t.startswith('List<') and n == '[list]':
        QMessageBox().information(msg_box_ui, "警告", "请为顶层List设置别名,该别名将成为顶级对象类名", QMessageBox.Ok)
        return ''

    return generate_code(work_bean)
