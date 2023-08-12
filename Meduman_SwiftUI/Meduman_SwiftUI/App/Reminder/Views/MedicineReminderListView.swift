//
//  MedicineReminderListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/8/23.
//

import SwiftUI


struct MedicineReminderListView: View {
    //MARK: - Parameters
    enum Parameters {
        static let borderWidth: CGFloat = 2
        static let afterMealColor: Color = Color(.systemOrange)
        static let beforeMealColor: Color = Color(.systemBlue)
    }
    
    //MARK: - Properties
    @EnvironmentObject var viewModel: MedicationReminderViewModel
    @State var isPresented: Bool = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List(self.viewModel.reminders) { reminder in
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(reminder.medicine)
                            .font(.system(size: 24))
                        Capsule()
                            .frame(width: 85, height: 20)
                            .foregroundColor(reminder.mealTime == "After Meal" ? Parameters.afterMealColor : Parameters.beforeMealColor)
                            .overlay {
                                Text(reminder.mealTime)
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                    .padding(5)
                            }
                    }
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 75, height: 75)
                        .foregroundColor(Color(.systemGray6))
                        .overlay {
                            Text(reminder.time, style: .time)
                                .frame(width: 50, alignment: .center)
                        }
                }
                .padding(.horizontal, 16)
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
