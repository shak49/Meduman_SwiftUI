//
//  HealthManger.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 11/22/22.
//

import HealthKit
import Combine


protocol HealthUseCaseProtocol {
    //MARK: - Properties
    var healthRepo: HealthRepository? { get }
    var articleRepo: ArticleRepository? { get }
    
    //MARK: - Lifecycles
    init(healthRepo: HealthRepository?, articleRepo: ArticleRepository?)
    
    //MARK: - Functions
    func fetchArticles() async
    func authorizeAccess()
    func createHealthRecord(object: HKObject?)
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKQuantitySample]?, HealthError>
    func removeHealthRecord(sample: HKQuantitySample)
}

class HealthUseCase: HealthUseCaseProtocol {
    //MARK: - Properties
    var healthRepo: HealthRepository?
    var articleRepo: ArticleRepository?
    private var cancellables = Set<AnyCancellable>()
    let allTypes: Set<HKSampleType> = Set([
        HKSampleType.quantityType(forIdentifier: .bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: .heartRate)!,
        HKSampleType.quantityType(forIdentifier: .bloodPressureSystolic)!
    ])
    
    //MARK: - Lifecycles
    required init(healthRepo: HealthRepository?, articleRepo: ArticleRepository?) {
        self.healthRepo = healthRepo
        self.articleRepo = articleRepo
    }
    
    //MARK: - Functions
    func fetchArticles() async {
        let queryItems = [
            URLQueryItem(name: "Type", value: "topic"),
            URLQueryItem(name: "Lang", value: "en"),
            URLQueryItem(name: "Lang", value: "en")
        ]
        await self.articleRepo?.fetchArticles(queryItems: queryItems)?
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { articles in
                print(articles)
            })
            .store(in: &self.cancellables)
    }
    
    func authorizeAccess() {
        self.healthRepo?.requestAuthorization(types: self.allTypes)
            .sink { completion in
                switch  completion {
                case .finished:
                    print("> AUTHORIZE COMPLETION:", completion)
                case .failure(let error):
                    print("> ERROR:", error.localizedDescription)
                }
            } receiveValue: { success in
                print("> AUTHORIZED: \(success)")
            }
            .store(in: &cancellables)
    }
    
    func createHealthRecord(object: HKObject?) {
        if let object = object {
            self.healthRepo?.writeHealthRecord(object: object)
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
    
    func readHealthRecord(type: HKSampleType?) -> AnyPublisher<[HKQuantitySample]?, HealthError> {
        let subject = PassthroughSubject<[HKQuantitySample]?, HealthError>()
        if let type = type {
            self.healthRepo?.readHealthRecord(type: type)
                .sink(receiveCompletion: { completion in
                    switch  completion {
                    case .finished:
                        print("> READ COMPLETION:", completion)
                    case .failure(let error):
                        print("> ERROR:", error.localizedDescription)
                    }
                }, receiveValue: { samples in
                    if let samples = samples {
                        print("> SAMPLES:", samples)
                        subject.send(samples)
                    }
                })
                .store(in: &cancellables)
                
        }
        return subject.eraseToAnyPublisher()
    }
    
    func removeHealthRecord(sample: HKQuantitySample) {
        self.healthRepo?.removeHealthRecord(object: sample)
            .sink(receiveCompletion: { completion in
                print("> DELETE COMPLETION:", completion)
            }, receiveValue: { result in
                print("> DELETED:", result)
            })
            .store(in: &cancellables)
    }
}
