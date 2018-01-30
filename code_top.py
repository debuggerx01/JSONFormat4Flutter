#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   code_top.py
# @Date     :   18-1-30 下午2:37
# @Author   :   DebuggerX


template_dict = r"""
import 'dart:convert';

class ${type} {
  ${properties}

  ${type}(jsonStr) {
    var json = JSON.decode(jsonStr);
    ${construction}
  }

  @override
  String toString() {
    return '{${toString}}';
  }
}
"""

template_list = r"""
import 'dart:convert';

class ${name} {
  ${type} list;

  ${type}(jsonStr) {
    var json = JSON.decode(jsonStr);
    list = new List();
    for (var item in json) {
      list.add(item);
    }
  }

  @override
  String toString() {
    return '{"list": $list}';
  }
}
"""


def get_top_code_dict(t):
    return template_dict.replace('${type}', t)


def get_top_code_list(t, n):
    res = template_list.replace('${type}', t).replace('${name}', n)

    if t[t.find('<') + 1: t.rfind('>')] not in ['int', 'double', 'bool', 'String']:
        res.replace('list.add(item);', )


    return res
