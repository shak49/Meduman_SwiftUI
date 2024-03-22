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
        VStack {
            if vm.isRecordsAvailable {
                GroupBox("Daily Progress") {
                    Chart {
                        ForEach(vm.dataLines) { dataLine in
                            ForEach(dataLine.samples) { sample in
                                LineMark(
                                    x: .value("date", sample.date),
                                    y: .value("record", sample.quantity)
                                )
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(by: .value("type", sample.type))
                            }
                        }
                    }
                    .frame(height: 200)
                    .chartLegend(position: .bottom, alignment: .center, spacing: 16)
                }
            }
            ArticleListView(articles: vm.articles, isLoading: vm.isLoading)
                .alert("Enter your information", isPresented: $vm.isFormPresented) {
                    TextField("Age", text: $vm.age)
                    TextField("Sex", text: $vm.sex)
                        .textCase(.lowercase)
                    Button("Submit") {
                        vm.getArticles(age: vm.age, sex: vm.sex)
                    }
                }
        }
    }
}

#Preview {
    HomeView()
}

struct ArticleListView: View {
    //MARK: - Properties
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    let articles: [Article]
    let isLoading: Bool
    
    //MARK: - Body
    var body: some View {
        if isLoading {
            ProgressView()
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(articles) { article in
                        ItemCellView(article: article)
                    }
                }
                .listStyle(.plain)
                .padding(.top, 32)
                .padding(.horizontal, 8)
            }
        }
    }
}

struct ItemCellView: View {
    //MARK: - Properties
    var article: Article
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: article.image) { image in
                image
                    .resizable()
            } placeholder: {
                // Placeholder Image
            }
            ZStack {
                Rectangle()
                    .foregroundStyle(.white)
                    .opacity(0.7)
                Text(article.title ?? "")
            }
            .frame(height: 50)
        }
        .frame(height: 170)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
