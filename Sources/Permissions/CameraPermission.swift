//
//  CameraPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 29/04/22.
//

import Foundation
import AVFoundation

class CameraPermission: PermissionProtocol {
    
    /**
     While Fetching Camera Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching Camera Permission
     - warning: If you use video recording we need to enable microphone permission also.
     
    **Notes:**
     1. **NSCameraUsageDescription**
        - A message that tells the user why the app is requesting access to the device’s camera.
     
     2. **NSMicrophoneUsageDescription**
        - A message that tells the user why the app is requesting access to the device’s microphone.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let status = AVCaptureDevice.authorizationStatus(for: .video)
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
        AVCaptureDevice.requestAccess(for: .video) { success in
            self.checkPermissionStatus(completionHandler)
        }
    }
    
}
