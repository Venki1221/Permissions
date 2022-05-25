//
//  PermissionModel.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 15/04/22.
//

import Foundation
import UIKit
import AVFAudio

public let PermissionManager = PermissionModel.shared

public class PermissionModel: NSObject {
    
    static let shared = PermissionModel()
    
    //Initializer access level change now
    private override init(){}
    
    public func checkPermissionStatus(_ permissionType:PermissionType, completionHandler: @escaping (_ response: Permissions) -> ()) {
        switch permissionType {
        case .notifications:
            NotificationPermission().checkPermissionStatus(completionHandler)
            break
            
        case .contacts:
            ContactsPermission().checkPermissionStatus(completionHandler)
            break
            
        case .location:
            LocationPermission().checkPermissionStatus(completionHandler)
            break
            
        case .michrophone:
            MicrophonePermission().checkPermissionStatus(completionHandler)
            break
            
        case .speechRecognition:
            SpeechRecognitionPermission().checkPermissionStatus(completionHandler)
            
        case .calenderEvent:
            CalenderEventPermission().checkPermissionStatus(completionHandler)
            
        case .calenderRemainder:
            CalenderRemainderPermission().checkPermissionStatus(completionHandler)
            
        case .camera:
            CameraPermission().checkPermissionStatus(completionHandler)
            
        case .photoLibrary:
            PhotoLibraryPermission().checkPermissionStatus(completionHandler)
            
        case .mediaLibrary:
            MediaLibraryPermission().checkPermissionStatus(completionHandler)
            
        case .bluetooth:
            BluetoothPermission().checkPermissionStatus(completionHandler)
            
        case .health:
            HealthPermisssion().checkPermissionStatus(completionHandler)
        }
    }
    
    public func requestPermission(_ permissionType:PermissionType, completionHandler: @escaping (_ response: Permissions) -> ()) {
        switch permissionType {
        case .notifications:
            NotificationPermission().requestPermission(completionHandler)
            break
            
        case .contacts:
            ContactsPermission().requestPermission(completionHandler)
            break
            
        case .location:
            LocationPermission().requestPermission(completionHandler)
            break
            
        case .michrophone:
            MicrophonePermission().requestPermission(completionHandler)
            break
            
        case .speechRecognition:
            SpeechRecognitionPermission().requestPermission(completionHandler)
            
        case .calenderEvent:
            CalenderEventPermission().requestPermission(completionHandler)
            
        case .calenderRemainder:
            CalenderRemainderPermission().requestPermission(completionHandler)
            
        case .camera:
            CameraPermission().requestPermission(completionHandler)
            
        case .photoLibrary:
            PhotoLibraryPermission().requestPermission(completionHandler)
            
        case .mediaLibrary:
            MediaLibraryPermission().requestPermission(completionHandler)
            
        case .bluetooth:
            BluetoothPermission().requestPermission(completionHandler)
            
        case .health:
            HealthPermisssion().requestPermission(completionHandler)
        }
    }
}

//MARK:- PermissionType
public enum PermissionType {
    case notifications, contacts, location, michrophone, speechRecognition, calenderEvent, calenderRemainder, camera, photoLibrary, bluetooth, mediaLibrary, health
    
    var notificationName: Notification.Name {
        switch self {
        case .notifications, .contacts, .location, .michrophone, .speechRecognition, .calenderEvent, .calenderRemainder, .camera, .photoLibrary, .bluetooth, .mediaLibrary, .health:
            return .didEnterForeground
        }
    }
}

//MARK:- Notification Name
public extension Notification.Name {
    static let didEnterForeground = UIApplication.willEnterForegroundNotification
}
