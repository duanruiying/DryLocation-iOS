//
//  DryLocation.swift
//  DryLocation-iOS
//
//  Created by WJ on 2019/8/30.
//

import UIKit
import CoreLocation

//MARK: - 状态
public enum DryLocationState {
    /// 未知
    case unknown
    /// 用户尚未就此应用程序做出选择
    case notDetermined
    /// 此应用程序无权使用位置服务
    case restricted
    /// 拒绝
    case denied
    /// 始终开启
    case authorizedAlways
    /// 在使用应用程序期间开启
    case authorizedWhenInUse
}

//MARK: - 闭包
/// 状态
public typealias ClosureDryLocationState    = (DryLocationState) -> Void
/// 纬度、经度
public typealias ClosureDryLocationLatLong  = (Double, Double) -> Void

//MARK: - DryLocation
public class DryLocation: NSObject {
    
    /// 定位管理器
    lazy var manager: CLLocationManager = {
        let m = CLLocationManager()
        m.delegate = DryLocation.shared()
        m.desiredAccuracy = kCLLocationAccuracyBest
        m.distanceFilter = 1
        return m
    }()
    /// 状态
    var stateClosure: ClosureDryLocationState?
    /// 纬度、经度
    var latLongClosure: ClosureDryLocationLatLong?
    
    /// 单例
    private static let instance = DryLocation()
    @discardableResult
    static func shared() -> DryLocation {
        return instance
    }
    
    /// 构造
    private override init() {}
    
    /// 析构
    deinit {}
}

//MARK: - DryLocation(定位权限状态)
extension DryLocation {
    
    /// @说明 当前定位权限状态
    /// @返回 DryLocationState
    @discardableResult
    public static func locationStatus() -> DryLocationState {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: return .notDetermined
        case .restricted: return .restricted
        case .denied: return .denied
        case .authorizedAlways: return .authorizedAlways
        case .authorizedWhenInUse: return .authorizedWhenInUse
        @unknown default: return .unknown
        }
    }
}

//MARK: - DryLocation(定位权限申请)
extension DryLocation {
    
    /// @说明 申请定位权限(使用时定位)
    /// @注释 info.plist配置[Privacy - Location When In Use Usage Description]
    /// @参数 resultHandler:  (状态、纬度、经度)回调
    /// @返回 void
    public static func accessUsage(_ resultHandler: @escaping ClosureDryLocationState) {
        DryLocation.shared().stateClosure = resultHandler
        DryLocation.shared().manager.requestWhenInUseAuthorization()
    }
    
    /// @说明 申请定位权限(一直定位)
    /// @注释 info.plist配置[Privacy - Location When In Use Usage Description]
    /// @注释 info.plist配置[Privacy - Location Always and When In Use Usage Description]
    /// @参数 resultHandler:  (状态、纬度、经度)回调
    /// @返回 void
    public static func accessAlways(_ resultHandler: @escaping ClosureDryLocationState) {
        DryLocation.shared().stateClosure = resultHandler
        DryLocation.shared().manager.requestAlwaysAuthorization()
    }
}

//MARK: - DryLocation(定位)
extension DryLocation {
    
    /// @说明 启动定位
    /// @参数 resultHandler: (纬度、经度)回调
    /// @返回 void
    public static func locationStart(_ resultHandler: @escaping ClosureDryLocationLatLong) {
        DryLocation.shared().latLongClosure = resultHandler
        DryLocation.shared().manager.startUpdatingLocation()
    }
    
    
    /// @说明 停止定位
    /// @返回 void
    public static func locationStop() {
        DryLocation.shared().manager.stopUpdatingLocation()
    }
}

//MARK: - DryLocation(CLLocationManagerDelegate)
extension DryLocation: CLLocationManagerDelegate {
    
    /// 定位状态回调
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        /// 检查闭包
        guard let closure = DryLocation.shared().stateClosure else {
            return
        }
        
        /// 回调状态
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: closure(.notDetermined)
        case .restricted: closure(.restricted)
        case .denied: closure(.denied)
        case .authorizedAlways: closure(.authorizedAlways)
        case .authorizedWhenInUse: closure(.authorizedWhenInUse)
        @unknown default: closure(.unknown)
        }
    }
    
    /// 位置更新回调
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        /// 检查闭包
        guard let closure = DryLocation.shared().latLongClosure else {
            return
        }
        
        /// 检查数据
        guard let last = locations.last else {
            return
        }
        
        /// 检查数据
        guard last.horizontalAccuracy > 0 else {
            return
        }
        
        /// 纬度
        let latitude: Double = last.coordinate.latitude
        
        /// 经度
        let longitude: Double = last.coordinate.longitude
        
        /// 回调
        closure(latitude, longitude)
    }
}
