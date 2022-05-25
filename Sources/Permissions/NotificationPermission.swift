//
//  NotificationPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 15/04/22.
//

import Foundation
import UserNotifications

class NotificationPermission: PermissionProtocol {
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus  {
            case .authorized:
                permissionObj = .authorized
            case .denied:
                permissionObj = .denied
            case .notDetermined:
                permissionObj = .notDetermined
            case .provisional:
                // @available(iOS 12.0, *)
                permissionObj = .provisional
            case .ephemeral:
                // @available(iOS 14.0, *)
                permissionObj = .ephemeral
            @unknown default:
                break
            }
            completionHandler(permissionObj)
        })
    }
   
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
            self.checkPermissionStatus(completionHandler)
        }
        
    }
    
}
