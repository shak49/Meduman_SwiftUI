//
//  HealthManager.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/15/22.
//

import HealthKit


protocol HealthManagerProtocol {
    //MARK: - Properties
    var healthRepo: HealthRepository? { get }
    
    //MARK: - Lifecycles
    init(healthRepo: HealthRepository?)
    
    //MARK: - Functions
    func requestAuthorization()
}

class HealthManager: HealthManagerProtocol {
    //MARK: - Properties
    var healthRepo: HealthRepository?
    
    //MARK: - Lifecycles
    required init(healthRepo: HealthRepository?) {
        self.healthRepo = healthRepo
    }
    
    //MARK: - Functions
    func requestAuthorization() {
        healthRepo?.requestAuthorization()
            .sink(receiveCompletion: { _ in
                print("FINISHED!")
            }, receiveValue: { [unowned self] authorized in
                print("AUTHORIZED: \(authorized)!")
            })
    }
}
