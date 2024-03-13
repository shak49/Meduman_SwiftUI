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
                    Label("Home", systemImage: "house")
                }
            HealthRecordsView()
                .tabItem {
                    Label("Health", systemImage: "heart")
                }
            MedicineReminderListView()
                .tabItem {
                    Label("Reminder", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    TabContainerView()
}
