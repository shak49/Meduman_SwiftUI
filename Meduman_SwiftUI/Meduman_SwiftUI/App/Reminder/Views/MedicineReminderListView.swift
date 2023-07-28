//
//  MedicineReminderListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/8/23.
//

import SwiftUI


struct MedicineReminderListView: View {
    //MARK: - Properties
    @EnvironmentObject var viewModel: MedicationReminderViewModel
    @State var isPresented: Bool = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List(self.viewModel.reminders) { reminder in
                VStack {
                    Text(reminder.medicine)
                    Text(reminder.description)
                }
            }
            .listStyle(.plain)
            .toolbar(content: {
                Button("Add") {
                    self.isPresented = true
                }
            })
            .sheet(isPresented: self.$isPresented, content: {
                CreateMedicationReminderView(isSheetPresented: self.$isPresented)
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
