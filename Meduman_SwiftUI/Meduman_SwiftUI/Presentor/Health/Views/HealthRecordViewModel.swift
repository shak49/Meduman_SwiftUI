//
//  HealthRecordViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit


protocol HealthRecordViewModelProtocol {
    //MARK: - Properties
    var useCase: HealthUseCase { get }
    
    //MARK: - Lifecycles
    init(useCase: HealthUseCase)
    
    //MARK: - Functions
    func authorize()
    func saveRecord(record: Double?, type: HKQuantityTypeIdentifier, unit: HealthUnit)
    func readRecord(type: HKSampleType?)
}

class HealthRecordViewModel: ObservableObject, HealthRecordViewModelProtocol {
    //MARK: - Properties
    var useCase: HealthUseCase
    var sampleConstructor = HealthSampleConstructor()
    
    //MARK: - Lifecycles
    required init(useCase: HealthUseCase) {
        self.useCase = useCase
    }
    
    //MARK: - Functions
    func authorize() {
        self.useCase.authorizeAccess()
    }
    
    func createRecord() {
        
    }
    
    func saveRecord(record: Double?, type: HKQuantityTypeIdentifier, unit: HealthUnit) {
        let object = self.sampleConstructor.quantitySample(record: record, typeId: type, unit: unit.rawValue)
        self.useCase.createHealthRecord(record: object)
    }
    
    func readRecord(type: HKSampleType?) {
        self.useCase.readHealthRecord(type: type)
            .compactMap { $0?.compactMap(HealthViewModel.init) }
            .eraseToAnyPublisher()
    }
}

struct HealthViewModel {
    var health: Health?
}
