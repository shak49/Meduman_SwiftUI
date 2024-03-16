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
            ForEach(vm.articles) { article in
                Text(article.title ?? "")
            }
            .navigationTitle("Articles")
        }
        .alert("Initial Alert", isPresented: $vm.isPresented) {
            TextField("Age", text: $vm.age)
            TextField("Sex", text: $vm.sex)
        }
    }
}

#Preview {
    ArticleListView()
}
