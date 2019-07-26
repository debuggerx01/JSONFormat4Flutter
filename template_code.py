#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   code_top.py
# @Date     :   18-1-30 下午2:37
# @Author   :   DebuggerX


template_dict = r"""

class ${type} {

${properties}

  ${type}.fromParams({${this.properties}});

  ${type}.fromJson(jsonRes) {
${construction}
  }

  @override
  String toString() {
    return '{${toString}}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ${type}${equals};
  }

  @override
  int get hashCode {
    return $jf(${hash});
  }
}

"""

template_list = r"""
  ${list_count}${class_type}${>count} ${name}${current_child} = ${name}${parent_items} == null ? null : [];
    for (var ${name}${current_items} in ${name}${current_child} == null ? [] : ${name}${parent_items}){
      ${loop}
      ${name}${current_child}.add(${name}${child_child});
    }
"""


def get_top_code_dict(t):
    return template_dict.replace('${type}', t)


def get_list_code_loop(list_count, ct, ab_count, n, current_child, child_child, current_items, parent_items):
    return template_list \
        .replace('${list_count}', list_count) \
        .replace('${class_type}', ct) \
        .replace('${>count}', ab_count) \
        .replace('${name}', n) \
        .replace('${current_child}', current_child) \
        .replace('${child_child}', child_child) \
        .replace('${current_items}', current_items) \
        .replace('${parent_items}', parent_items)
