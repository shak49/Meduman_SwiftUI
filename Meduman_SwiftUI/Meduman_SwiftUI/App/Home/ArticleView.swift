//
//  ArticleView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 3/22/24.
//

import SwiftUI

struct ArticleView: View {
    //MARK: - Properties
    let article: Article
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: article.image) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {}
                VStack(alignment: .leading, spacing: 16) {
                    Text(article.title ?? UIText.empty)
                        .font(.system(size: 26))
                        .bold()
                    ForEach(article.section?.paragraphs ?? []) { paragraph in
                        Text(paragraph.body ?? UIText.empty)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 32)
            }
        }
        .background(Color.placeholder)
        .ignoresSafeArea()
    }
}

#Preview {
    ArticleView(article: Article(id: UIText.empty, title: nil, imageString: nil, section: Section(paragraphs: [])))
}
