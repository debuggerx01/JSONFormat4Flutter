# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mainwindow.ui'
#
# Created by: PyQt5 UI code generator 5.6
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(927, 724)
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Preferred, QtWidgets.QSizePolicy.Preferred)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(MainWindow.sizePolicy().hasHeightForWidth())
        MainWindow.setSizePolicy(sizePolicy)
        MainWindow.setMinimumSize(QtCore.QSize(800, 600))
        MainWindow.setMaximumSize(QtCore.QSize(16777215, 16777215))
        self.centralWidget = QtWidgets.QWidget(MainWindow)
        self.centralWidget.setObjectName("centralWidget")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.centralWidget)
        self.verticalLayout.setContentsMargins(11, 11, 11, 11)
        self.verticalLayout.setSpacing(6)
        self.verticalLayout.setObjectName("verticalLayout")
        self.frame = QtWidgets.QFrame(self.centralWidget)
        self.frame.setFrameShape(QtWidgets.QFrame.StyledPanel)
        self.frame.setFrameShadow(QtWidgets.QFrame.Raised)
        self.frame.setObjectName("frame")
        self.verticalLayout_4 = QtWidgets.QVBoxLayout(self.frame)
        self.verticalLayout_4.setContentsMargins(11, 11, 11, 11)
        self.verticalLayout_4.setSpacing(6)
        self.verticalLayout_4.setObjectName("verticalLayout_4")
        self.splitter = QtWidgets.QSplitter(self.frame)
        self.splitter.setOrientation(QtCore.Qt.Horizontal)
        self.splitter.setObjectName("splitter")
        self.widget = QtWidgets.QWidget(self.splitter)
        self.widget.setObjectName("widget")
        self.verticalLayout_3 = QtWidgets.QVBoxLayout(self.widget)
        self.verticalLayout_3.setSizeConstraint(QtWidgets.QLayout.SetDefaultConstraint)
        self.verticalLayout_3.setContentsMargins(11, 11, 11, 11)
        self.verticalLayout_3.setSpacing(6)
        self.verticalLayout_3.setObjectName("verticalLayout_3")
        self.btn_format = QtWidgets.QPushButton(self.widget)
        self.btn_format.setObjectName("btn_format")
        self.verticalLayout_3.addWidget(self.btn_format)
        self.te_json = QtWidgets.QTextEdit(self.widget)
        self.te_json.setObjectName("te_json")
        self.verticalLayout_3.addWidget(self.te_json)
        self.widget1 = QtWidgets.QWidget(self.splitter)
        self.widget1.setObjectName("widget1")
        self.verticalLayout_2 = QtWidgets.QVBoxLayout(self.widget1)
        self.verticalLayout_2.setContentsMargins(11, 11, 11, 11)
        self.verticalLayout_2.setSpacing(6)
        self.verticalLayout_2.setObjectName("verticalLayout_2")
        self.btn_generate = QtWidgets.QPushButton(self.widget1)
        self.btn_generate.setObjectName("btn_generate")
        self.verticalLayout_2.addWidget(self.btn_generate)
        self.lv_fields = QtWidgets.QListWidget(self.widget1)
        self.lv_fields.setObjectName("lv_fields")
        self.verticalLayout_2.addWidget(self.lv_fields)
        self.verticalLayout_4.addWidget(self.splitter)
        self.verticalLayout.addWidget(self.frame)
        MainWindow.setCentralWidget(self.centralWidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "JSONFormat4Flutter"))
        self.btn_format.setText(_translate("MainWindow", "格式化"))
        self.btn_generate.setText(_translate("MainWindow", "生成Bean"))


if __name__ == "__main__":
    import sys

    app = QtWidgets.QApplication(sys.argv)
    widget = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(widget)
    widget.show()
    sys.exit(app.exec_())

