//
//  SpeechRecognitionPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 22/04/22.
//

import Foundation
import Speech

class SpeechRecognitionPermission: NSObject, PermissionProtocol {

    /**
     While Fetching Speech Recognition Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching Speech Recognition Permission
     
    **Notes:**
     1. **NSSpeechRecognitionUsageDescription**
        - A message that tells the user why the app is requesting to send user data to Apple’s speech recognition servers.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        let permissionObj = self.checkStatus()
        completionHandler(permissionObj)
    }
    
    private func checkStatus() -> Permissions{
        var permissionObj = Permissions.unKnown
        let status = SFSpeechRecognizer.authorizationStatus()
        switch status {
        case .notDetermined:
            permissionObj = .notDetermined
            break
        case .denied:
            permissionObj = .denied
            break
        case .restricted:
            permissionObj = .restricted
            break
        case .authorized:
            permissionObj = .authorized
            break
        @unknown default:
            break
        }
        return permissionObj
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        SFSpeechRecognizer.requestAuthorization { status in
            self.checkPermissionStatus(completionHandler)
        }
    }
    
}
