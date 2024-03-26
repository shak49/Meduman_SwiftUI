//
//  HomeView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/6/24.
//

import SwiftUI
import Charts


struct HomeView: View {
    //MARK: - Properties
    @StateObject var vm = HomeVM()
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                if vm.isRecordsAvailable {
                    RecordChartView(title: UIText.dailyProgress, dataLines: vm.dataLines)
                }
                if vm.isLoading {
                    ProgressView()
                } else {
                    ArticleListView(articles: vm.articles)
                        .alert(UIText.alertTitle, isPresented: $vm.isFormPresented) {
                            TextField(UIText.age, text: $vm.age)
                            TextField(UIText.sex, text: $vm.sex)
                                .textCase(.lowercase)
                            Button(UIText.submit) {
                                vm.getArticles(age: vm.age, sex: vm.sex)
                            }
                        }
                }
            }
            .refreshable { await vm.populateUI() }
        }
    }
}

#Preview {
    HomeView()
}

struct RecordChartView: View {
    //MARK: - Properties
    let title: String
    let dataLines: [DataLineVM]
    
    //MARK: - Body
    var body: some View {
        GroupBox(title) {
            Chart {
                ForEach(dataLines) { dataLine in
                    ForEach(dataLine.samples) { sample in
                        LineMark(
                            x: .value(UIText.date, sample.date),
                            y: .value(UIText.record, sample.quantity)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(by: .value(UIText.type, sample.type))
                    }
                }
            }
            .frame(height: 200)
            .chartLegend(position: .bottom, alignment: .center, spacing: 16)
        }
    }
}

struct ArticleListView: View {
    //MARK: - Properties
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    let articles: [Article]
    
    //MARK: - Body
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(articles) { article in
                    NavigationLink {
                        ArticleView(article: article)
                    } label: {
                        ArticleCellView(article: article)
                    }
                }
            }
            .padding(.top, 32)
            .padding(.horizontal, 8)
        }
    }
}

struct ArticleCellView: View {
    //MARK: - Properties
    let article: Article
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: article.image) { image in
                image
                    .resizable()
            } placeholder: {}
            ZStack {
                Rectangle()
                    .foregroundStyle(.white)
                    .opacity(0.7)
                Text(article.title ?? UIText.empty)
                    .foregroundStyle(.black)
            }
            .frame(height: 50)
        }
        .frame(height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
