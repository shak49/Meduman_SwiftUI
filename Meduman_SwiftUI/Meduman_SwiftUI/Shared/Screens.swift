//
//  Screens.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/26/24.
//

import SwiftUI

enum Screens {
    case signInView
    
    var initiate: any View {
        switch self {
        case .signInView:
            return SignInView()
        }
    }
}
