//
//  HealthRecordViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit


protocol HealthViewModelProtocol {
    //MARK: - Properties
    var useCase: HealthUseCase { get }
    
    //MARK: - Lifecycles
    init(useCase: HealthUseCase)
    
    //MARK: - Functions
    func authorize()
}

class HealthViewModel: ObservableObject, HealthViewModelProtocol {
    //MARK: - Properties
    var useCase: HealthUseCase
    
    //MARK: - Lifecycles
    required init(useCase: HealthUseCase) {
        self.useCase = useCase
    }
    
    //MARK: - Functions
    func authorize() {
        useCase.authorizeAccess()
    }
    
}
