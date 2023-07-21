//
//  MedicationReminderView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 7/7/23.
//

import SwiftUI


enum Frequency: String, CaseIterable, Identifiable {
    case day = "Day"
    case week = "Week"
    case month = "Month"
    case year = "Year"
    
    var id: String { self.rawValue }
}

enum MealTime: String, CaseIterable, Identifiable {
    case beforeMeal = "Before Meal"
    case afterMeal = "After Meal"
    
    var id: String { self.rawValue }
}

struct CreateMedicationReminderView: View {
    //MARK: - Properties
    @State private var medicine: String = ""
    @State private var dosage: String = ""
    @State private var frequency: Frequency = Frequency.day
    @State private var mealTime: MealTime = MealTime.beforeMeal
    @State private var dateAndTime: Date = Date()
    @State private var note: String = ""
    @Binding var isSheetPresented: Bool
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Medicine")
                    Spacer()
                    TextField("Enter medicine name...", text: self.$medicine)
                        .frame(width: 200, alignment: .trailing)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                HStack {
                    Text("Dosage")
                    Spacer()
                    TextField("Enter medicine dosage...", text: self.$dosage)
                        .frame(width: 200, alignment: .trailing)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                VStack {
                    Text("Start Date")
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    DatePicker("", selection: self.$dateAndTime, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }
                Picker("", selection: self.$frequency) {
                    ForEach(Frequency.allCases) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .cornerRadius(12.5)
                        .foregroundColor(Color(.systemGreen))
                    Text("Time")
                        .padding(.leading, 8)
                }
                .padding(.horizontal, 16)
                Picker("", selection: self.$mealTime) {
                    ForEach(MealTime.allCases) { time in
                        Text(time.rawValue)
                            .tag(time)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                TextEditor(text: self.$note)
                    .frame(height: 250)
                    .font(.body)
                    .border(Color(.systemGray6), width: 2)
                    .padding(.horizontal, 16)
            }
            .listStyle(.plain)
            .padding(.top, 32)
            .toolbar(content: {
                HStack {
                    Button("Dismiss") {
                        self.isSheetPresented = false
                    }
                    Button("Save") {
                        self.isSheetPresented = false
                    }
                }
            })
            .navigationTitle(Text("New Reminder"))
        }
    }
}

struct MedicationReminderView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMedicationReminderView(isSheetPresented: .constant(false))
    }
}
