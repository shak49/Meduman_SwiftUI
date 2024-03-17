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

enum AlertError: LocalizedError {
    case message(error: String)
    
    var description: String? {
        switch self {
        case .message(error: let error):
            return error
        }
    }
}

final class ArticleListViewModel: BaseVM {
    //MARK: - Properties
    private var service = ArticleService.shared
    @Published private(set) var articles: [Article] = []
    @Published private(set) var alertError: AlertError?
    @Published var isFormPresented: Bool = true
    @Published var isErrorPresented: Bool = false
    var age: String = ""
    var sex: String = ""
    
    //MARK: - Functions
    func getArticles(age: String, sex: String) {
        Task {
            let result = await service.getArticles(age: age, sex: sex)
            switch result {
            case .success(let articles):
                await MainActor.run {
                    self.articles = articles
                    isFormPresented = false
                }
            case .failure(let error):
                isErrorPresented = true
                alertError = .message(error: error.localizedDescription)
                break
            }
        }
    }
}
