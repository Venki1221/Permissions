//
//  BluetoothPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 29/04/22.
//

import Foundation
import CoreBluetooth

class BluetoothPermission: NSObject, PermissionProtocol, CBCentralManagerDelegate {
    
    private var manager: CBCentralManager?
    private var requestManagerAuthorizationCallback: ((Bool) -> Void)?
    
    /**
     While Fetching Bluetooth Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching Bluetooth Permission
     
    **Notes:**
     1. **NSBluetoothAlwaysUsageDescription**
        - A message that tells the user why the app needs access to Bluetooth.
     2. **NSBluetoothPeripheralUsageDescription**
        - A message that tells the user why the app is requesting the ability to connect to Bluetooth peripherals.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.unKnown
        let status = CBManager.authorization
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
        case .allowedAlways:
            permissionObj = .authorized
            break
        @unknown default:
            break
        }
        completionHandler(permissionObj)
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        if self.manager == nil{
            self.manager = CBCentralManager(delegate: self, queue: nil)
        }
        self.requestManagerAuthorizationCallback = { status in
            self.checkPermissionStatus(completionHandler)
        }
        //self.checkPermissionStatus(completionHandler)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        let state = central.state
        switch state {
        case .unknown:
            break
        case .resetting:
            break
        case .unsupported:
            break
        case .unauthorized:
            break
        case .poweredOff:
            break
        case .poweredOn:
            break
        @unknown default:
            break
        }
        self.requestManagerAuthorizationCallback?(true)
    }
    
}
