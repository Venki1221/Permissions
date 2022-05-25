//
//  LocationPermission.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 22/04/22.
//

import Foundation
import CoreLocation

class LocationPermission: NSObject,  PermissionProtocol {
    
    private var locationManager = CLLocationManager()
    private var requestLocationAuthorizationCallback: ((CLAuthorizationStatus) -> Void)?
    
    override init(){
        super.init()
        self.locationManager.delegate = self
    }
    
    /**
     While Fetching Location Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching location
     
    **Notes:**
     1. **NSLocationWhenInUseUsageDescription**
        - Your app requests When In Use authorization or Always authorization.
     1. **NSLocationAlwaysAndWhenInUseUsageDescription**
        - Your app requests Always authorization.
     1. **NSLocationAlwaysUsageDescription**
        - Your app supports iOS 10 and earlier and requests Always authorization.
     1. **NSLocationUsageDescription**
        - Your app runs in macOS and uses location services.
     */
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        self.requestLocationAuthorizationCallback = { status in
            let permissionObj = self.getPermissionObj()
            completionHandler(permissionObj)
        }
    }
    
    private func getPermissionObj() -> Permissions {
        var permissionObj = Permissions.notAvailable
        if CLLocationManager.locationServicesEnabled() {
            let status = locationManager.authorizationStatus
            switch status{
            case .notDetermined:
                permissionObj = .notDetermined
                break
            case .restricted:
                permissionObj = .restricted
                break
            case .denied:
                permissionObj = .denied
                break
            case .authorizedAlways:
                permissionObj = .authorized
                break
            case .authorizedWhenInUse:
                permissionObj = .authorized
                break
            case .authorized:
                permissionObj = .authorized
                break
            @unknown default:
                permissionObj = .unKnown
                break
            }
        }
        return permissionObj
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        self.requestLocationAuthorizationCallback = { status in
            if status == .authorizedWhenInUse {
                self.locationManager.requestAlwaysAuthorization()
            }
            let permissionObj = self.getPermissionObj()
            completionHandler(permissionObj)
        }
        self.locationManager.requestWhenInUseAuthorization()
    }
    
}

extension LocationPermission: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.requestLocationAuthorizationCallback?(manager.authorizationStatus)
    }
    
}
