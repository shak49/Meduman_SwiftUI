//
//  SettingsView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/26/24.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    @StateObject private var vm = SettingsVM()
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Age")
                    Spacer()
                    TextField("", text: vm.$age)
                        .frame(width: 50, alignment: .center)
                        .padding(8)
                        .background(Color.placeholder)
                        .cornerRadius(10)
                }
                HStack {
                    Text("Sex")
                    Spacer()
                    TextField("", text: vm.$sex)
                        .frame(width: 50, alignment: .center)
                        .textCase(.lowercase)
                        .padding(8)
                        .background(Color.placeholder)
                        .cornerRadius(10)
                }
            }
            .padding(.top, 16)
            .navigationTitle("Settings")
            .toolbar {
                Button {
                    vm.signOut()
                } label: {
                    Text("Sign Out")
                        .padding(8)
                        .foregroundStyle(.red)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8, style: .continuous)
                                .stroke(.red)
                        }
                }
            }
            .background(Color.placeholder)
        }
    }
}

#Preview {
    SettingsView()
}
