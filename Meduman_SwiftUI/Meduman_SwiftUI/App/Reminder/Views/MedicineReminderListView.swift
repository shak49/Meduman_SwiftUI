//
//  MedicineReminderListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/8/23.
//

import SwiftUI


struct MedicineReminderListView: View {
    //MARK: - Properties
    @State private var isPresented: Bool = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List {
                
            }
            .toolbar(content: {
                Button("Add") {
                    self.isPresented = true
                }
            })
            .sheet(isPresented: self.$isPresented, content: {
                CreateMedicationReminderView(isPresented: self.$isPresented)
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
