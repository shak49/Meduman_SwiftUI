//
//  NetworkClientArticleSuccessMock.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/25/24.
//

import Foundation
@testable import Meduman_SwiftUI


final class NetworkClientArticleSuccessMock: NetworkClientProtocol {
    //MARK: - Properties
    
    //MARK: - Functions
    func request<RESP>(endpoint: Meduman_SwiftUI.Endpoint, type: RESP.Type) async throws -> RESP where RESP : Decodable, RESP : Encodable {
        return try StaticJSONMapper.decode(file: "ArticleResponse", type: ArticleResponse.self) as! RESP
    }
    
}
