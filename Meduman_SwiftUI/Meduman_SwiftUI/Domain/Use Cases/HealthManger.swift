//
//  HealthManger.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit


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
        repo.requestAuthorization { results in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let authorized):
                print(authorized)
            }
        }
    }
}
