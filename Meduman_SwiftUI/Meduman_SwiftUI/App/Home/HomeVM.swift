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

class HomeVM: BaseVM {
    //MARK: - Properties
    private var healthService: HealthService? = HealthService(healthStore: HKHealthStore())
    private var articleService = ArticleService()
    private var cancellables = Set<AnyCancellable>()
    private let healthSamples = [
        HKSampleType.quantityType(forIdentifier: .bloodGlucose),
        HKSampleType.quantityType(forIdentifier: .heartRate),
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)
    ]
    @Published private(set) var dataLines: [DataLine] = []
    @Published private(set) var articles: [Article] = []
    @Published private(set) var alertError: AlertError?
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var isRecordsAvailable: Bool = false
    @Published var isFormPresented: Bool = true
    @Published var isErrorPresented: Bool = false

    //MARK: - Functions
    func populateChart() {
        for sample in healthSamples {
            readRecord(type: sample)
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
                        let glucose = self.convertSampleToDataLine(type: "Glucose", sample: sample)
                        self.dataLines.append(glucose)
                        self.isRecordsAvailable = true
                    } else if sample.quantityType == .init(.bloodPressureSystolic) {
                        let pressure = self.convertSampleToDataLine(type: "Pressure", sample: sample)
                        self.dataLines.append(pressure)
                        self.isRecordsAvailable = true
                    } else if sample.quantityType == .init(.heartRate) {
                        let heartRate = self.convertSampleToDataLine(type: "Heart Rate", sample: sample)
                        self.dataLines.append(heartRate)
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

extension HomeVM {
    func convertSampleToDataLine(type: String, sample: HKQuantitySample) -> DataLine {
        var glucoseSamples: [Record] = []
        glucoseSamples.append(Record(quantitySample: sample))
        return DataLine(type: type, samples: glucoseSamples)
    }
}
