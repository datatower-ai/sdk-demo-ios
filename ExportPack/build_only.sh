#!/bin/sh

# 注意事项
# 1、如果提示permission denied: ./package.sh ， 则先附加权限，命令如下：chmod 777 package.sh
# 2、请根据自己项目的情况选择使用 workspace 还是 project 形式，目前默认为 workspace 形式

### 需要根据自己项目的情况进行修改，XXX都是需要进行修改的，可搜索进行修改 ###

#xcodebuild -list 查看所有的target，schma和Configurations

# Project名称
PROJECT_NAME=demo

## Scheme名
SCHEME_NAME=demoObjc

## 编译类型 Debug/Release二选一
BUILD_TYPE=Release

## 项目根路径，xcodeproj/xcworkspace所在路径
PROJECT_ROOT_PATH=../

## 打包生成路径
PRODUCT_PATH=./output

## workspace路径
WORKSPACE_PATH=${PROJECT_ROOT_PATH}/${PROJECT_NAME}.xcworkspace

## project路径
PROJECT_PATH=${PROJECT_ROOT_PATH}/${PROJECT_NAME}.xcodeproj

### 编译打包过程 ###

echo "============Build Clean Begin============"

## 清理缓存

## project形式
# xcodebuild clean -project ${PROJECT_PATH} -scheme ${SCHEME_NAME} -configuration ${BUILD_TYPE} || exit

## workspace形式
xcodebuild clean -workspace ${WORKSPACE_PATH} -scheme ${SCHEME_NAME} -configuration ${BUILD_TYPE} || exit

echo "============Build Clean End============"

#获取Version
VERSION_NUMBER=$(sed -n '/MARKETING_VERSION = /{s/MARKETING_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}' ${PROJECT_PATH}/project.pbxproj)
# 获取build
BUILD_NUMBER=$(sed -n '/CURRENT_PROJECT_VERSION = /{s/CURRENT_PROJECT_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}' ${PROJECT_PATH}/project.pbxproj)

## 编译开始时间,注意不可以使用标点符号和空格
BUILD_START_DATE="$(date +'%Y-%m-%d_%H-%M')"

## IPA所在目录路径
IPA_DIR_NAME=${VERSION_NUMBER}_${BUILD_NUMBER}_${BUILD_START_DATE}

##xcarchive文件的存放路径
ARCHIVE_PATH=${PRODUCT_PATH}/IPA/${IPA_DIR_NAME}/${SCHEME_NAME}.xcarchive
## ipa文件的存放路径
IPA_PATH=${PRODUCT_PATH}/IPA/${IPA_DIR_NAME}

# 解锁钥匙串 -p后跟为电脑密码
# security unlock-keychain -p XXX

echo "============Build App Begin============"
## 导出archive包

## project形式
# xcodebuild archive -project ${PROJECT_PATH} -scheme ${SCHEME_NAME} -archivePath ${ARCHIVE_PATH}

## workspace形式
xcodebuild -workspace ${WORKSPACE_PATH} -scheme ${SCHEME_NAME} -destination 'generic/platform=iOS' -quiet || exit

echo "============Build App Success============"
