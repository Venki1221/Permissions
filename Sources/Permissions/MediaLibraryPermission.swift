//
//  MediaLibraryPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 29/04/22.
//

import Foundation
import MediaPlayer

class MediaLibraryPermission: PermissionProtocol {
    
    /**
     While Fetching Media Library Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching Media Library Permission
     
    **Notes:**
     1. **NSAppleMusicUsageDescription**
        - A message that tells the user why the app is requesting access to the user’s media library.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let status = MPMediaLibrary.authorizationStatus()
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
        MPMediaLibrary.requestAuthorization { status in
            self.checkPermissionStatus(completionHandler)
        }
    }
    
}

