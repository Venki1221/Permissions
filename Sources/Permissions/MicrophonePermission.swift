//
//  MicrophonePermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 22/04/22.
//

import Foundation
import AVKit

class MicrophonePermission: PermissionProtocol {
    
    /**
     While Fetching Michrophone Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching Microphone Permission
     
    **Notes:**
     1. **NSMicrophoneUsageDescription**
        - A message that tells the user why the app is requesting access to the device’s microphone.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let status = AVAudioSession.sharedInstance().recordPermission
        switch status {
        case .undetermined:
            permissionObj = .notDetermined
            break
        case .denied:
            permissionObj = .denied
            break
        case .granted:
            permissionObj = .authorized
            break
        @unknown default:
            break
        }
        completionHandler(permissionObj)
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        AVAudioSession.sharedInstance().requestRecordPermission { success in
            self.checkPermissionStatus(completionHandler)
        }
    }
    
}
