#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   code_top.py
# @Date     :   18-1-30 下午2:37
# @Author   :   DebuggerX


template_dict = r"""

class ${type} {

${properties}
  
  ${type}(jsonRes) {
${construction}
  }

  @override
  String toString() {
    return '{${toString}}';
  }
}

"""


def get_top_code_dict(t):
    return template_dict.replace('${type}', t)
