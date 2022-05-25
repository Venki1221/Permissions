//
//  ContactsPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 15/04/22.
//

import Foundation
import Contacts

class ContactsPermission: PermissionProtocol {
    
    /**
     While Fetching Contacts Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching contacts
     
    **Notes:**
     1. **NSContactsUsageDescription**
        - A message that tells the user why the app is requesting access to the user’s contacts.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let contactsStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch contactsStatus {
        case .notDetermined:
            permissionObj = .notDetermined
        case .restricted:
            permissionObj = .restricted
        case .denied:
            permissionObj = .denied
        case .authorized:
            permissionObj = .authorized
        @unknown default:
            break
        }
        completionHandler(permissionObj)
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        
        CNContactStore().requestAccess(for: .contacts) { success, error in
            self.checkPermissionStatus(completionHandler)
        }
        
    }
    
}
