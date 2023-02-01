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
    var records: [HealthViewModel] { get }
    
    //MARK: - Lifecycles
    init(useCase: HealthUseCase)
    
    //MARK: - Functions
    func authorize()
    func createBloodGlucose(record: Double?, dateAndTime: Date, mealTime: String)
    //func readRecord(type: HKSampleType?)
}

struct HealthViewModel: Identifiable {
    //MARK: - Properties
    private var health: Health?
    var id: String? {
        return health?.id
    }
    var record: Double? {
        return health?.record
    }
    var typeId: String? {
        return "\(health?.typeId)"
    }
    var unit: String? {
        return health?.unit
    }
    var date: Date? {
        return health?.date
    }
}

class HealthRecordViewModel: ObservableObject, HealthRecordViewModelProtocol {
    //MARK: - Properties
    var useCase: HealthUseCase
    @Published var records: [HealthViewModel] = []
    let bloodGlucoseSample = HKSampleType.quantityType(forIdentifier: .bloodGlucose)
    
    //MARK: - Lifecycles
    required init(useCase: HealthUseCase) {
        self.useCase = useCase
        //self.readRecord(type: bloodGlucoseSample)
    }
    
    //MARK: - Functions
    func authorize() {
        self.useCase.authorizeAccess()
    }
    
    func createBloodGlucose(record: Double?, dateAndTime: Date, mealTime: String) {
        guard let record = record else { return }
        let health = Health(record: record, typeId: .bloodGlucose, unit: "mg/dL", date: dateAndTime)
        let object = Constructor.shared.quantitySample(health: health)
        self.useCase.createHealthRecord(record: object)
    }
    
//    func readRecord(type: HKSampleType?) {
//        self.useCase.readHealthRecord(type: type)
//            .compactMap { self.records = $0?.compactMap(HealthViewModel.init)}
//            .eraseToAnyPublisher()
//    }
}
