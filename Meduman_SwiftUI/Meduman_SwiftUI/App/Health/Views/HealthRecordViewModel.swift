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
    var repo: HealthRepository? { get }
    var records: [HKQuantitySample] { get }
    
    //MARK: - Lifecycles
    init(repo: HealthRepository?)
    
    //MARK: - Functions
    func createHealthRecord(object: HKObject?)
    func readRecord(type: HKSampleType?)
    func removeRecord(indexSet: IndexSet)
}

class HealthRecordViewModel: ObservableObject, HealthRecordViewModelProtocol {
    //MARK: - Properties
    var repo: HealthRepository?
    private var cancellables = Set<AnyCancellable>()
    private var currentQuantitySample: HKQuantitySample?
    @Published var records: [HKQuantitySample] = []
    let healthSamples = [
        HKSampleType.quantityType(forIdentifier: .bloodGlucose),
        HKSampleType.quantityType(forIdentifier: .heartRate),
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)
    ]
    
    //MARK: - Lifecycles
    required init(repo: HealthRepository?) {
        self.repo = repo
        self.repo?.requestAuthorization()
        getSamples()
    }
    
    //MARK: - Functions
    func getSamples() {
        for sample in healthSamples {
            readRecord(type: sample)
        }
    }
    
    func createBloodGlucose(record: Double?, dateAndTime: Date) {
        guard let record = record else { return }
        let bloodGlucose = Health(record: record, typeId: .bloodGlucose, unit: HealthUnit.bloodGlucose.rawValue, date: dateAndTime)
        guard let object = Constraint.shared.quantitySample(health: bloodGlucose) else { return }
        self.records.append(object)
        createHealthRecord(object: object)
    }
    
    func createHeartRate(record: Double?, dateAndTime: Date) {
        guard let record = record else { return }
        let heartRate = Health(record: record, typeId: .heartRate, unit: HealthUnit.heartRate.rawValue, date: dateAndTime)
        guard let object = Constraint.shared.quantitySample(health: heartRate) else { return }
        self.records.append(object)
        createHealthRecord(object: object)
    }
    
    func createBloodPressure(record: Double?, dateAndTime: Date) {
        guard let record = record else { return }
        let bloodPressure = Health(record: record, typeId: .bloodPressureSystolic, unit: HealthUnit.bloodPressure.rawValue, date: dateAndTime)
        guard let object = Constraint.shared.quantitySample(health: bloodPressure) else { return }
        self.records.append(object)
        createHealthRecord(object: object)
    }
    
    func createHealthRecord(object: HKObject?) {
        if let object = object {
            self.repo?.writeHealthRecord(object: object)
                .sink(receiveCompletion: { completion in
                    switch  completion {
                    case .finished:
                        print("> CREATE COMPLETION:", completion)
                    case .failure(let error):
                        print("> ERROR:", error)
                    }
                }, receiveValue: { result in
                    print("> SAVED:", result)
                })
                .store(in: &cancellables)
        }
    }
    
    func readRecord(type: HKSampleType?) {
        guard let type = type else { return }
        self.repo?.readHealthRecord(type: type)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch  completion {
                case .finished:
                    print(completion)
                case .failure(let error):
                    print("> ERROR:", error.localizedDescription)
                }
            }, receiveValue: { samples in
                guard let samples = samples else { return }
                samples.compactMap {
                    self.records.append($0) }
            })
            .store(in: &cancellables)
    }
    
    func removeRecord(indexSet: IndexSet) {
        indexSet.forEach { index in
            self.repo?.removeHealthRecord(object: self.records[index].self)
            self.records.remove(at: index)
        }
    }
}