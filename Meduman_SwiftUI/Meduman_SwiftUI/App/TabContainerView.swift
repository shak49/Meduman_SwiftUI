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
                    Label(UIText.home, systemImage: Symbol.house)
                }
            HealthRecordsView()
                .tabItem {
                    Label(UIText.health, systemImage: Symbol.heart)
                }
            SettingsView()
                .tabItem {
                    Label(UIText.settings, systemImage: Symbol.gear)
                }
        }
    }
}

#Preview {
    TabContainerView()
}
