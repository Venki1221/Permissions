//
//  HealthPermisssion.swift
//  CRAppPermissions
//
//  Created by Venkatesh Muppuri on 29/04/22.
//

import Foundation
import HealthKit

class HealthPermisssion: PermissionProtocol {
    
    private var isHealthKitAvailable: Bool {
        guard HKHealthStore.isHealthDataAvailable() else {
          return false
        }
        return true
    }
    
    /**
     While Fetching HealthKit Permission do as follows Notes
     
     - returns: Permission Status
     - warning: Must add Privacy Details in Info.plist while fetching HealthKit Permission
     - warning: Must add healthkit entitlement
     
    **Notes:**
     1. **NSHealthUpdateUsageDescription**
        - A message to the user that explains why the app requested permission to save samples to the HealthKit store.
     2. **NSHealthShareUsageDescription**
        - A message to the user that explains why the app requested permission to read samples from the HealthKit store.
     */
    
    func checkPermissionStatus(_ completionHandler: @escaping (Permissions) -> ()) {
        var permissionObj = Permissions.notAvailable
        if self.isHealthKitAvailable{
            let status = HKHealthStore().authorizationStatus(for: .workoutType())
            switch status {
            case .notDetermined:
                permissionObj = .notDetermined
                break
            case .sharingDenied:
                permissionObj = .denied
                break
            case .sharingAuthorized:
                permissionObj = .authorized
                break
            @unknown default:
                permissionObj = .unKnown
                break
            }
        }
        completionHandler(permissionObj)
    }
    
    func requestPermission(_ completionHandler: @escaping (Permissions) -> ()) {
        self.fetchAllAccess { access, writeSamples, readSample in
            if access {
                HKHealthStore().requestAuthorization(toShare: writeSamples, read: readSample) { success, error in
                    self.checkPermissionStatus(completionHandler)
                }
            } else {
                self.checkPermissionStatus(completionHandler)
            }
        }
    }
    
    private func fetchAllAccess(_ completionHandler: @escaping (_ access:Bool, _ writeSamples: Set<HKSampleType>, _ readSample: Set<HKObjectType>) -> ()){
        guard let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
                let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType),
                let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
                let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex),
                let height = HKObjectType.quantityType(forIdentifier: .height),
                let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass),
                let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completionHandler(false,[], [])
            return
        }
        
        let healthKitTypesToWrite: Set<HKSampleType> = [bodyMassIndex,
                                                        activeEnergy,
                                                        HKObjectType.workoutType()]
            
        let healthKitTypesToRead: Set<HKObjectType> = [dateOfBirth,
                                                       bloodType,
                                                       biologicalSex,
                                                       bodyMassIndex,
                                                       height,
                                                       bodyMass,
                                                       HKObjectType.workoutType()]
        
        completionHandler(true,healthKitTypesToWrite, healthKitTypesToRead)
    }
    
    
}
