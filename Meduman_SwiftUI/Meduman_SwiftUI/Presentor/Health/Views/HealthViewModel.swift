//
//  HealthViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/16/22.
//

import HealthKit


protocol HealthViewModelProtocol {
    //MARK: - Properties
    var manager: HealthManager? { get }
    
    //MARK: - Lifecycles
    init(manager: HealthManager?)
    
    //MARK: - Functions
    func authorize()
}

class HealthViewModel: ObservableObject, HealthViewModelProtocol {
    //MARK: - Properties
    var manager: HealthManager?
    
    //MARK: - Lifecycles
    required init(manager: HealthManager?) {
        self.manager = manager
    }
    
    //MARK: - Functions
    func authorize() {
        manager?.requestAuthorization()
    }
}
