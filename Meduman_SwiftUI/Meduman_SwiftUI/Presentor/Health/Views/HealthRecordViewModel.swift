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
    func createBloodGlucose(record: Double?, dateAndTime: Date, mealTime: String)
    func readRecord(type: HKSampleType?)
}

class HealthRecordViewModel: ObservableObject, HealthRecordViewModelProtocol {
    //MARK: - Properties
    var useCase: HealthUseCase
    
    //MARK: - Lifecycles
    required init(useCase: HealthUseCase) {
        self.useCase = useCase
    }
    
    //MARK: - Functions
    func authorize() {
        self.useCase.authorizeAccess()
    }
    
    func createBloodGlucose(record: Double?, dateAndTime: Date, mealTime: String) {
        guard let record = record else { return }
        let object = Constructor.shared.quantitySample(record: record, typeId: .bloodGlucose, unit: HealthUnit.glucose.rawValue, date: dateAndTime)
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
