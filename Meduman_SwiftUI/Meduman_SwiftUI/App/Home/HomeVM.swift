//
//  HomeVM.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/9/24.
//

import SwiftUI
import HealthKit
import Combine


enum GenderType: String {
    case female = "Female"
    case male = "Male"
    
    var value: String { rawValue }
}

enum AlertError: LocalizedError {
    case message(error: String)
    
    var description: String? {
        switch self {
        case .message(error: let error):
            return error
        }
    }
}

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
    //MARK: - Properties
    private var healthService: HealthService? = HealthService(healthStore: HKHealthStore())
    private var articleService = ArticleService.shared
    private var cancellables = Set<AnyCancellable>()
    private let healthSamples = [
        HKSampleType.quantityType(forIdentifier: .bloodGlucose),
        HKSampleType.quantityType(forIdentifier: .heartRate),
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)
    ]
    @Published private(set) var dataLines: [DataLineVM] = []
    @Published private(set) var articles: [Article] = []
    @Published private(set) var alertError: AlertError?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isRecordsAvailable: Bool = false
    @Published var isFormPresented: Bool = true
    @Published var isErrorPresented: Bool = false
    @AppStorage("age") var age: String = ""
    @AppStorage("sex") var sex: String = ""
    
    //MARK: - Lifecycles
    override init() {
        super.init()
        Task { await populateUI() }
    }
    
    //MARK: - Functions
    func populateUI() async {
        for sample in healthSamples {
            readRecord(type: sample)
        }
        if !age.isEmpty && !sex.isEmpty {
            isFormPresented = false
            getArticles(age: age, sex: sex)
        }
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
    
    func getArticles(age: String, sex: String) {
        isLoading = true
        Task {
            let result = await articleService.getArticles(age: age, sex: sex)
            switch result {
            case .success(let articles):
                await MainActor.run {
                    self.articles = articles
                    isFormPresented = false
                    isLoading = false
                }
            case .failure(let error):
                isErrorPresented = true
                alertError = .message(error: error.localizedDescription)
                break
            }
        }
    }
}
