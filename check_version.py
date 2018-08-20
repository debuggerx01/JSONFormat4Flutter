#!/usr/bin/env python
# -*- coding:utf-8 -*-
# @Filename :   check_version.py
# @Date     :   18-8-20 上午1:52
# @Author   :   DebuggerX

import configparser
from urllib import request
from json import loads

from PyQt5 import QtGui, QtCore
from PyQt5.QtCore import QThread, pyqtSignal
from PyQt5.QtWidgets import QMessageBox
from tools import msg_box_ui

code = 0.5
ignore_code = 0.0

check_last_version_thread = None


def _check_ignore_version():
    config = configparser.ConfigParser()
    global ignore_code
    # noinspection PyBroadException
    try:
        config.read('.ignore.cfg')
        ignore_code = float(config.get('version', 'code'))
    except Exception:
        pass


class CheckLastVersion(QThread):
    trigger = pyqtSignal(dict)

    def run(self):
        res_json = None
        # noinspection PyBroadException
        try:
            res = request.urlopen('https://raw.githubusercontent.com/debuggerx01/JSONFormat4Flutter/master/version')
            res_json = loads(res.read().decode())
        except Exception:
            pass
        if res_json is not None:
            global code
            if res_json['code'] > code and res_json['code'] > ignore_code:
                self.trigger.emit(res_json)


def check_last_version_handler(json_obj):
    res = QMessageBox().information(msg_box_ui, "有新版本更新！", "新版本(v%s)更新内容：\n%s\n\n点击[确定]转跳到下载页，点击[取消]忽略该版本提醒" % (json_obj['code'], json_obj['desc']),
                                    QMessageBox.Ok,
                                    QMessageBox.Cancel)
    if res == QMessageBox.Cancel:
        config = configparser.ConfigParser()
        config.add_section('version')
        config.set('version', 'code', str(json_obj['code']))
        with open('.ignore.cfg', 'w') as configfile:
            config.write(configfile)
    else:
        QtGui.QDesktopServices.openUrl(QtCore.QUrl('https://github.com/debuggerx01/JSONFormat4Flutter/releases'))


def check_version():
    _check_ignore_version()

    global check_last_version_thread
    check_last_version_thread = CheckLastVersion()
    check_last_version_thread.trigger.connect(check_last_version_handler)
    check_last_version_thread.start()
    return code
