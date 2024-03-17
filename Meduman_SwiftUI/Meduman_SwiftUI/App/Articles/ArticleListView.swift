//
//  ArticleListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/15/24.
//

import SwiftUI

struct ArticleListView: View {
    //MARK: - Properties
    @StateObject var vm = ArticleListViewModel()
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.articles) { article in
                    HStack {
                        AsyncImage(url: URL(string: article.imageUrl ?? "")) { image in
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
            .navigationTitle("Articles")
        }
        .alert("Initial Alert", isPresented: $vm.isFormPresented) {
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

#Preview {
    ArticleListView()
}
