//
//  PhotoLibraryPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 29/04/22.
//

import Foundation
import Photos

class PhotoLibraryPermission: PermissionProtocol {
    
    /**
     While Fetching Photo Library Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching Photo Library Permission
     
    **Notes:**
     1. **NSPhotoLibraryUsageDescription**
        - A message that tells the user why the app is requesting access to the user’s photo library.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
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
        case .limited:
            permissionObj = .limited
        @unknown default:
            break
        }
        completionHandler(permissionObj)
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            self.checkPermissionStatus(completionHandler)
        }
    }
    
}
