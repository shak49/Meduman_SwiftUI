//
//  HealthRecordViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit
import Combine


protocol HealthRecordViewModelProtocol {
    //MARK: - Properties
    var useCase: HealthUseCase { get }
    var records: [HKQuantitySample] { get }
    
    //MARK: - Lifecycles
    init(useCase: HealthUseCase)
    
    //MARK: - Functions
    func authorize()
    func createBloodGlucose(record: Double?, dateAndTime: Date, mealTime: String)
    func readRecord(type: HKSampleType?)
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
    private var cancellables = Set<AnyCancellable>()
    let bloodGlucoseSample = HKSampleType.quantityType(forIdentifier: .bloodGlucose)
    @Published var records: [HKQuantitySample] = []
    
    //MARK: - Lifecycles
    required init(useCase: HealthUseCase) {
        self.useCase = useCase
        self.readRecord(type: bloodGlucoseSample)
    }
    
    //MARK: - Functions
    func authorize() {
        self.useCase.authorizeAccess()
    }
    
    func createBloodGlucose(record: Double?, dateAndTime: Date, mealTime: String) {
        guard let record = record else { return }
        let health = Health(record: record, typeId: .bloodGlucose, unit: HealthUnit.bloodGlucose.rawValue, date: dateAndTime)
        let object = Constructor.shared.quantitySample(health: health)
        self.useCase.createHealthRecord(record: object)
    }
    
    func readRecord(type: HKSampleType?) {
        self.useCase.readHealthRecord(type: type)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { records in
                guard let records = records else { return }
                self.records = records
            })
            .store(in: &cancellables)
    }
}
