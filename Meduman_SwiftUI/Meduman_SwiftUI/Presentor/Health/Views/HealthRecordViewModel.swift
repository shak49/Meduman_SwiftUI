//
//  HealthRecordViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit


protocol HealthRecordVMProtocol {
    //MARK: - Properties
    var manager: HealthManager { get }
    
    //MARK: - Lifecycles
    init(manager: HealthManager)
    
    //MARK: - Functions
    func authorize()
}

class HealthRecordViewModel: ObservableObject, HealthRecordVMProtocol {
    //MARK: - Properties
    var manager: HealthManager
    
    //MARK: - Lifecycles
    required init(manager: HealthManager) {
        self.manager = manager
    }
    
    //MARK: - Functions
    func authorize() {
        manager.authorizeAccess()
    }
}
