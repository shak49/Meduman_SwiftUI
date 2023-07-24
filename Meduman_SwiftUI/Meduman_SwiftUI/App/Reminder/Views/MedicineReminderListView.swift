//
//  MedicineReminderListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/8/23.
//

import SwiftUI


struct MedicineReminderListView: View {
    //MARK: - Properties
    @ObservedObject var viewModel = MedicationReminderViewModel()
    @State private var isPresented: Bool = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.reminders) { reminder in
                    Text(reminder.medicine)
                }
            }
            .sheet(isPresented: self.$isPresented, content: {
                CreateMedicationReminderView(isSheetPresented: self.$isPresented)
            })
            .toolbar(content: {
                Button("Add") {
                    self.isPresented = true
                }
            })
            .navigationTitle("Reminders")
        }
    }
}

struct MedicineReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineReminderListView()
    }
}
