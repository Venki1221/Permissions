//
//  CalenderRemainderPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 29/04/22.
//

import Foundation
import EventKit

class CalenderRemainderPermission: PermissionProtocol {
    
    private let eventStore = EKEventStore()
    
    /**
     While Fetching Calender Remainder Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching Calender Remainder Permission
     
    **Notes:**
     1. **NSRemindersUsageDescription**
        - A message that tells the user why the app is requesting access to the user’s reminders.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let status = EKEventStore.authorizationStatus(for: .reminder)
        switch status {
        case .notDetermined:
            permissionObj = .notDetermined
            break
        case .restricted:
            permissionObj = .restricted
            break
        case .denied:
            permissionObj = .denied
            break
        case .authorized:
            permissionObj = .authorized
            break
        @unknown default:
            break
        }
        completionHandler(permissionObj)
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        eventStore.requestAccess(to: .reminder) { success, error in
            self.checkPermissionStatus(completionHandler)
        }
    }
    
}
