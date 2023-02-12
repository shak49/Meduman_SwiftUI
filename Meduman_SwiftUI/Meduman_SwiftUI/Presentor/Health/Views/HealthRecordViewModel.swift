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
    func createBloodGlucose(record: Double?, dateAndTime: Date)
    func createHeartRate(record: Double?, dateAndTime: Date)
    func createBloodPressure(record: Double?, dateAndTime: Date)
    func readRecord(type: HKSampleType?)
    func removeRecord(index: IndexSet?)
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
    let healthSamples = [
        HKSampleType.quantityType(forIdentifier: .bloodGlucose),
        HKSampleType.quantityType(forIdentifier: .heartRate),
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)
    ]
    var useCase: HealthUseCase
    private var cancellables = Set<AnyCancellable>()
    @Published var records: [HKQuantitySample] = []
    
    //MARK: - Lifecycles
    required init(useCase: HealthUseCase) {
        self.useCase = useCase
        self.authorize()
        populateList()
    }
    
    //MARK: - Functions
    func populateList() {
        for sample in healthSamples {
            self.readRecord(type: sample)
        }
    }
    
    func authorize() {
        self.useCase.authorizeAccess()
    }
    
    func createBloodGlucose(record: Double?, dateAndTime: Date) {
        guard let record = record else { return }
        let bloodGlucose = Health(record: record, typeId: .bloodGlucose, unit: HealthUnit.bloodGlucose.rawValue, date: dateAndTime)
        let object = Constructor.shared.quantitySample(health: bloodGlucose)
        self.useCase.createHealthRecord(object: object)
    }
    
    func createHeartRate(record: Double?, dateAndTime: Date) {
        guard let record = record else { return }
        let heartRate = Health(record: record, typeId: .heartRate, unit: HealthUnit.heartRate.rawValue, date: dateAndTime)
        let object = Constructor.shared.quantitySample(health: heartRate)
        self.useCase.createHealthRecord(object: object)
    }
    
    func createBloodPressure(record: Double?, dateAndTime: Date) {
        guard let record = record else { return }
        let bloodPressure = Health(record: record, typeId: .bloodPressureSystolic, unit: HealthUnit.bloodPressure.rawValue, date: dateAndTime)
        let object = Constructor.shared.quantitySample(health: bloodPressure)
        self.useCase.createHealthRecord(object: object)
    }
    
    func readRecord(type: HKSampleType?) {
        self.useCase.readHealthRecord(type: type)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { records in
                guard let records = records else { return }
                records.compactMap { self.records.append($0) }
            })
            .store(in: &cancellables)
    }
    
    func removeRecord(index: IndexSet?) {
        guard let index = index else { return }
//        index.forEach { healthRecord in
//            self.useCase.removeHealthRecord(health: healthRecord)
//        }
    }
}
