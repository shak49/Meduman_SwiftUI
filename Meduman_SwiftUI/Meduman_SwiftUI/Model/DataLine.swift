//
//  DataLine.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 4/11/24.
//

import Foundation

struct DataLine: Identifiable {
    let id = UUID().uuidString
    let type: String
    let samples: [RecordVM]
}
