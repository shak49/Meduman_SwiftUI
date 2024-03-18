//
//  ArticleListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/15/24.
//

import SwiftUI

struct ArticleListView: View {
    //MARK: - Properties
    @ObservedObject var vm: HomeVM
    
    //MARK: - Body
    var body: some View {
        if vm.isLoading {
            ProgressView()
        } else {
            List {
                ForEach(vm.articles) { article in
                    HStack {
                        AsyncImage(url: article.image) { image in
                            image
                                .resizable()
                                .frame(width: 75, height: 75)
                        } placeholder: {
                            // Placeholder Image
                        }
                        Text(article.title ?? "")
                    }
                }
            }
            .listStyle(.plain)
            .padding(.top, 32)
            .alert("Enter your information", isPresented: $vm.isFormPresented) {
                TextField("Age", text: $vm.age)
                TextField("Sex", text: $vm.sex)
                    .textCase(.lowercase)
                Button("Ok") {
                    vm.getArticles(age: vm.age, sex: vm.sex)
                }
            }
            .alert(isPresented: $vm.isErrorPresented, error: vm.alertError) {
                Button("Ok") {
                    vm.isErrorPresented = false
                }
            }
        }
    }
}

#Preview {
    ArticleListView(vm: HomeVM())
}
