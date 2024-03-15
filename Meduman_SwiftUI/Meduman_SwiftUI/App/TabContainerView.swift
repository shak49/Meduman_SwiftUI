//
//  TabView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/6/24.
//

import SwiftUI

struct TabContainerView: View {
    //MARK: - Body
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: Symbol.house)
                }
            ArticleListView()
                .tabItem {
                    Label("Article", systemImage: Symbol.article)
                }
            HealthRecordsView()
                .tabItem {
                    Label("Health", systemImage: Symbol.heart)
                }
            MedicineReminderListView()
                .tabItem {
                    Label("Reminder", systemImage: Symbol.calendar)
                }
        }
    }
}

#Preview {
    TabContainerView()
}
