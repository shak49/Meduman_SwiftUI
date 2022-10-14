//
//  HKHealthStoreMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 10/12/22.
//

import HealthKit
@testable import Meduman_SwiftUI


enum HKAuthorizationStatusMock {
    case notDetermined
    case sharingAuthorized
    case sharingDenied
}

class HKHealthStoreMock: HKHealthStore {
    //MARK: - Properties
    
    //MARK: - Functions
    override func authorizationStatus(for type: HKObjectType) -> HKAuthorizationStatusMock {
        
    }
    
    override func requestAuthorization(toShare typesToShare: Set<HKSampleType>?, read typesToRead: Set<HKObjectType>?, completion: @escaping (Bool, Error?) -> Void) {
        <#code#>
    }
    
    override func save(_ objects: [HKObject]) async throws {
        <#code#>
    }
}
