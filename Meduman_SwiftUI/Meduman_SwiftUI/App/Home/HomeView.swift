//
//  HomeView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 12/15/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: HealthRecordsView()) {
                Text("Health Records")
            }
            NavigationLink(destination: MedicineReminderListView()) {
                Text("Medicine Reminders")
            }
        }
    }
}

#Preview {
    HomeView()
}
