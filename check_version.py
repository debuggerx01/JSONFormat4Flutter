#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   check_version.py
# @Date     :   18-8-20 上午1:52
# @Author   :   DebuggerX

import configparser
import os
import ssl
import sys
from urllib import request
from json import loads

from PyQt5 import QtGui, QtCore
from PyQt5.QtCore import QThread, pyqtSignal
from PyQt5.QtWidgets import QMessageBox
from tools import msg_box_ui

code = 0.7
ignore_code = 0.0

check_last_version_thread = None


def get_exe_path():
    if getattr(sys, 'frozen', False):
        return os.path.dirname(sys.executable)
    else:
        return os.path.dirname(__file__)


def _check_ignore_version():
    config = configparser.ConfigParser()
    global ignore_code
    # noinspection PyBroadException
    try:
        config.read(os.path.join(get_exe_path(), '.ignore.cfg'))
        ignore_code = float(config.get('version', 'code'))
    except Exception:
        pass


class CheckLastVersion(QThread):
    trigger = pyqtSignal(dict)

    def run(self):
        res_json = None
        # noinspection PyBroadException
        try:
            res = request.urlopen('https://raw.githubusercontent.com/debuggerx01/JSONFormat4Flutter/master/version',
                                  context=ssl._create_unverified_context())
            res_json = loads(res.read().decode())
        except Exception:
            pass
        if res_json is not None:
            global code
            if res_json['code'] > code and res_json['code'] > ignore_code:
                self.trigger.emit(res_json)


def check_last_version_handler(json_obj):
    msg_box = QMessageBox()
    msg_box.addButton('确定', QMessageBox.AcceptRole)
    msg_box.addButton('忽略', QMessageBox.NoRole)
    msg_box.addButton('关闭', QMessageBox.RejectRole)
    msg_box.setParent(msg_box_ui)
    msg_box.setWindowTitle("有新版本更新！")
    msg_box.setText("新版本(v%s)更新内容：\n%s\n\n点击[确定]转跳到下载页，点击[忽略]忽略该版本提醒，点击[关闭]退出本提示框" % (json_obj['code'], json_obj['desc']))

    res = msg_box.exec()
    if res == QMessageBox.RejectRole:
        config = configparser.ConfigParser()
        config.add_section('version')
        config.set('version', 'code', str(json_obj['code']))
        with open(os.path.join(get_exe_path(), '.ignore.cfg'), 'w') as configfile:
            config.write(configfile)
    elif res == QMessageBox.AcceptRole:
        QtGui.QDesktopServices.openUrl(QtCore.QUrl('https://github.com/debuggerx01/JSONFormat4Flutter/releases'))


def check_version():
    _check_ignore_version()

    global check_last_version_thread
    check_last_version_thread = CheckLastVersion()
    check_last_version_thread.trigger.connect(check_last_version_handler)
    check_last_version_thread.start()
    return code
