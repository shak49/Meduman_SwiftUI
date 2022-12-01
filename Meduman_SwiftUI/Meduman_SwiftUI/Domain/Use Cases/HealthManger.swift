//
//  HealthManger.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit
import XCTest


protocol HealthManagerProtocol {
    //MARK: - Properties
    var repo: HealthRepository { get }
    
    //MARK: - Lifecycles
    init(repo: HealthRepository)
    
    //MARK: - Functions
    func requestAuthorization()
}

class HealthManager: HealthManagerProtocol {
    //MARK: - Properties
    var repo: HealthRepository
    
    //MARK: - Lifecycles
    required init(repo: HealthRepository) {
        self.repo = repo
    }
    
    //MARK: - Functions
    func requestAuthorization() {
        repo.requestAuthorization { authorized, error in
            if error != nil {
                print(error)
            }
            guard let authorized = authorized else { return }
            XCTAssertTrue(authorized)
        }
    }
}
