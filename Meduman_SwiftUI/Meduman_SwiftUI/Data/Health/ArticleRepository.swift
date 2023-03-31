//
//  ArticleRepository.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/31/23.
//

import Foundation


protocol ArticleRepositoryProtocol {
    //MARK: - Properties
    var session: URLSession? { get }
    
    //MARK: - Lifecycles
    init(session: URLSession?)
    
    //MARK: - Functions
}


class ArticleRepository: ArticleRepositoryProtocol {
    //MARK: - Properties
    let session: URLSession?
    
    //MARK: - Lifecycles
    required init(session: URLSession?) {
        self.session = session
    }
    
    //MARK: - Functions
}
