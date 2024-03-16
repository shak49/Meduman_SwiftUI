//
//  ArticleListViewModel.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/15/24.
//

import Foundation


enum GenderType: String {
    case female = "Female"
    case male = "Male"
    
    var value: String { rawValue }
}

enum AlertMessage {
    case success(message: String)
    case error(message: String)
    case none
    
    var description: String? {
        switch self {
        case .success(message: let message):
            return message
        case .error(message: let message):
            return message
        case .none:
            return nil
        }
    }
}

final class ArticleListViewModel: BaseVM {
    //MARK: - Properties
    private var service: ArticleService?
    @Published private(set) var articles: [Article] = []
    var alertMessage: AlertMessage = .none
    var isPresented: Bool = true
    var age: String = ""
    var sex: String = ""
    
    //MARK: - Lifecycles
    override init() {
        super.init()
        getArticles()
    }
    
    //MARK: - Functions
    private func getArticles() {
        Task {
            let result = await service?.getArticles(age: age, sex: sex)
            switch result {
            case .success(let articles):
                await MainActor.run {
                    self.articles = articles
                    self.isPresented = false
                    alertMessage = .success(message: UIText.successAlertMessage)
                }
            case .failure(let error):
                alertMessage = .error(message: error.localizedDescription)
                break
            case .none:
                break
            }
        }
    }
}
