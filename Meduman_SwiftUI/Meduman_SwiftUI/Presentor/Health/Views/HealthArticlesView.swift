//
//  HealthArticlesView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 4/17/23.
//

import SwiftUI


struct HealthArticlesView: View {
    //MARK: - Properties
    static var session = URLSession()
    static var articleRepo = ArticleRepository(session: session)
    var useCase = HealthUseCase(healthRepo: nil, articleRepo: articleRepo)
    @EnvironmentObject var healthModel: HealthRecordViewModel
    
    //MARK: - Lifecycles
    
    //MARK: - Body
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onSubmit {
                Task {
                    await self.healthModel.fetchArticles()
                }
            }
    }
}

struct HealthArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        HealthArticlesView()
    }
}
