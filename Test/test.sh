#!/usr/bin/env bash

# 下载依赖
env PUB_ALLOW_PRERELEASE_SDK=quiet $(echo $(which flutter) | awk '{print substr($0,0,length()-7)}')cache/dart-sdk/bin/pub get

# 运行测试
echo test start...
$(echo $(which flutter) | awk '{print substr($0,0,length()-7)}')cache/dart-sdk/bin/dart test.dart
