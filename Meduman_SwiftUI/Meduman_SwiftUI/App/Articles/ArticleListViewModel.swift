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

final class ArticleListViewModel: BaseVM {
    //MARK: - Properties
    private var service: ArticleService?
    @Published private(set) var articles: [Article] = []
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
                print(articles)
                self.isPresented = false
                self.articles = articles
            case .failure(let error):
                print(error)
                break
            case .none:
                break
            }
        }
    }
}
