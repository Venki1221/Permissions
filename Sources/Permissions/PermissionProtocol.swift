//
//  PermissionProtocol.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 15/04/22.
//

import Foundation

public enum Permissions {
    case authorized, limited, denied, notDetermined, restricted, provisional, ephemeral, unKnown, notAvailable
    
    public var status: String {
        switch self {
        case .authorized:
            return "Authorized"
        case .limited:
            return "Limited"
        case .denied:
            return "Denied"
        case .notDetermined:
            return "NotDetermined"
        case .restricted:
            return "Restricted"
        case .provisional:
            return "Provisional"
        case .ephemeral:
            return "Ephemeral"
        case .unKnown:
            return "UnKnown"
        case .notAvailable:
            return "Not Available"
        }
    }
    
    public var statusDescp: String {
        switch self {
        case .authorized:
            return "User granted permission"
        case .limited:
            return "User granted permission for limited access"
        case .denied:
            return "User denied permission"
        case .notDetermined:
            return "Permission haven't been asked yet"
        case .restricted:
            return "User restricted the permission"
        case .provisional:
            return "The application is authorized to post non-interruptive user notifications."
        case .ephemeral:
            return "The application is temporarily authorized to post notifications. Only available to app clips."
        case .unKnown:
            return "Unknown Status"
        case .notAvailable:
            return "This device doesn't support the service"
        }
    }
    
}

protocol PermissionProtocol {
    
    /// This function returns a Permission Status
    func checkPermissionStatus(_ completionHandler: @escaping (_ response: Permissions) -> ())
    
    /// This function request the permission and returns the Auth Status
    func requestPermission(_ completionHandler: @escaping (_ response: Permissions) -> ())
    
}
