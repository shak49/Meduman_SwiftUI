//
//  GoogleAuthButton.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/1/24.
//

import SwiftUI


struct GoogleAuthButton: View {
    //MARK: - Properties
    let content: () -> Void
    
    //MARK: - Body
    var body: some View {
        Button {
            content()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.systemGray)
                HStack(spacing: 10) {
                    Image("google-icon")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("Sign In With Google")
                        .foregroundColor(.black)
                }
            }
            .frame(height: 50)
        }
    }
}
