//
//  ArticleListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/15/24.
//

import SwiftUI

struct ArticleListView: View {
    //MARK: - Properties
    let articles: [Article]
    let isLoading: Bool
    
    //MARK: - Body
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            List {
                ForEach(articles) { article in
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
        }
    }
}

#Preview {
    ArticleListView(articles: [], isLoading: false)
}
