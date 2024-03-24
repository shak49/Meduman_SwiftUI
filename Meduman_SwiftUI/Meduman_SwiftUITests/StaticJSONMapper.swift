//
//  StaticJSONMapper.swift
//  Meduman_SwiftUITests
//
//  Created by Shak Feizi on 3/24/24.
//

import Foundation


struct StaticJSONMapper {
    //MARK: - Functions
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        guard !file.isEmpty, let path = Bundle.main.path(forResource: file, ofType: "json"), let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContent
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContent
    }
}
