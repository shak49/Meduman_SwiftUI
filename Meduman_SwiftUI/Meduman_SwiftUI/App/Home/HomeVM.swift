//
//  HomeVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/9/24.
//

import Foundation
import HealthKit
import Combine


struct DataLineVM: Identifiable {
    let id = UUID().uuidString
    let type: String
    let samples: [RecordVM]
}

struct RecordVM: Hashable, Identifiable {
    var quantitySample: HKQuantitySample
    var id: String = UUID().uuidString
    var quantity: Double {
        var newString = ""
        for char in "\(quantitySample.quantity)" {
            if char.isNumber {
                newString += String(char)
            }
        }
        return Double(newString) ?? 0
    }
    var type: String {
        switch quantitySample.quantityType {
        case HKQuantityType(.bloodGlucose):
            return "Glucose"
        case HKQuantityType(.bloodPressureSystolic):
            return "Pressure"
        case HKQuantityType(.heartRate):
            return "Heart"
        default:
            break
        }
        return ""
    }
    var sample: HKSampleType? {
        return quantitySample.sampleType
    }
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: quantitySample.endDate).capitalized
    }
}

class HomeVM: BaseVM {
    //MARK: - Prooperties
    private var healthService: HealthService? = HealthService(healthStore: HKHealthStore())
    private var cancellables = Set<AnyCancellable>()
    private let healthSamples = [
        HKSampleType.quantityType(forIdentifier: .bloodGlucose),
        HKSampleType.quantityType(forIdentifier: .heartRate),
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)
    ]
    @Published var dataLines: [DataLineVM] = []
    @Published var reminders: [Reminder] = []
    @Published var isRecordsAvailable: Bool = false
    
    //MARK: - Lifecycles
    override init() {
        super.init()
        populateUI()
    }
    
    //MARK: - Functions
    func populateUI() {
        for sample in healthSamples {
            readRecord(type: sample)
        }
        getReminders()
    }
    
    func readRecord(type: HKSampleType?) {
        guard let type = type else { return }
        self.healthService?.readHealthRecord(type: type)
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
                        var glucoseSamples: [RecordVM] = []
                        glucoseSamples.append(RecordVM(quantitySample: sample))
                        let dataLine = DataLineVM(type: "Glucose", samples: glucoseSamples)
                        self.dataLines.append(dataLine)
                        self.isRecordsAvailable = true
                    } else if sample.quantityType == .init(.bloodPressureSystolic) {
                        var pressureSamples: [RecordVM] = []
                        pressureSamples.append(RecordVM(quantitySample: sample))
                        let dataLine = DataLineVM(type: "Pressure", samples: pressureSamples)
                        self.dataLines.append(dataLine)
                        self.isRecordsAvailable = true
                    } else if sample.quantityType == .init(.heartRate) {
                        var heartSamples: [RecordVM] = []
                        heartSamples.append(RecordVM(quantitySample: sample))
                        let dataLine = DataLineVM(type: "Heart", samples: heartSamples)
                        self.dataLines.append(dataLine)
                        self.isRecordsAvailable = true
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func getReminders() {
        DispatchQueue.main.async {
            self.firebaseService.fetchListOfReminders { reminder, error in
                if error != nil {
                    print(error)
                }
                guard let reminder = reminder else { return }
                self.reminders.append(reminder)
                self.reminders.sorted { $0.time < $1.time }
            }
        }
    }
}
