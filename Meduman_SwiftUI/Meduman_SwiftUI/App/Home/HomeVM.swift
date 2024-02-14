//
//  HomeVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/9/24.
//

import Foundation
import HealthKit
import Combine


struct RecordVM: Hashable, Identifiable {
    var quantitySample: HKQuantitySample?
    var id: String = UUID().uuidString
    var quantity: Int {
        guard let quantitySample = quantitySample else { return 0 }
        var newString = ""
        for char in "\(quantitySample.quantity)" {
            if char.isNumber {
                newString += String(char)
            }
        }
        return Int(newString) ?? 0
    }
    var type: HKQuantityType? {
        guard let quantitySample = quantitySample else { return nil }
        return quantitySample.quantityType
    }
    var sample: HKSampleType? {
        guard let quantitySample = quantitySample else { return nil  }
        return quantitySample.sampleType
    }
    var endDate: String {
        guard let quantitySample = quantitySample else { return "" }
        return "\(quantitySample.endDate)"
    }
}

class HomeVM: ObservableObject {
    //MARK: - Prooperties
    private var service: HealthService? = HealthService(healthStore: HKHealthStore())
    private var cancellables = Set<AnyCancellable>()
    private let healthSamples = [
        HKSampleType.quantityType(forIdentifier: .bloodGlucose),
        HKSampleType.quantityType(forIdentifier: .heartRate),
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)
    ]
    @Published var records: [String : [RecordVM]] = ["Glucose" : [], "Pressure" : [], "Heart" : []]
    
    //MARK: - Lifecycles
    init() {
        getSamples()
    }
    
    //MARK: - Functions
    func getSamples() {
        for sample in healthSamples {
            readRecord(type: sample)
        }
    }
    
    func readRecord(type: HKSampleType?) {
        guard let type = type else { return }
        self.service?.readHealthRecord(type: type)
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
                samples.forEach { sample in
                    if sample.quantityType == .init(.bloodGlucose) {
                        self.records["Glucose"]?.append(RecordVM(quantitySample: sample))
                        self.records["Glucose"]?.sorted { $0.quantity < $1.quantity } ?? []
                    } else if sample.quantityType == .init(.bloodPressureSystolic) {
                        self.records["Pressure"]?.append(RecordVM(quantitySample: sample))
                        self.records["Pressure"]?.sorted { $0.quantity < $1.quantity } ?? []
                    } else {
                        self.records["Heart"]?.append(RecordVM(quantitySample: sample))
                        self.records["Heart"]?.sorted { $0.quantity < $1.quantity } ?? []
                    }
                }
            })
            .store(in: &cancellables)
    }
}
