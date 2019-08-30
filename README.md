# DryLocation-iOS
iOS: 简单集成系统定位状态获取、定位权限申请、经纬度获取

## Prerequisites
* iOS 10.0+
* Swift 5.0+

## Installation
* pod 'DryLocation-iOS'

## Features
### 获取当前定位权限状态
```
DryLocation.locationStatus()
```
### 申请定位权限
```
DryLocation.accessUsage { (state) in
}

DryLocation.accessAlways { (state) in
}
```
### 启动定位
```
DryLocation.locationStart({ (lat, long) in
})
```
### 停止定位
```
DryLocation.locationStop()
```
