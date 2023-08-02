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
    //MARK: - Parameters
    private enum Parameters {
        static let textfieldWidth: CGFloat = 200
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
        static let listPaddingTop: CGFloat = 32
        static let iconWidth: CGFloat = 25
        static let buttonColor: Color = Color(.systemGreen)
        static let textEditorHeight: CGFloat = 250
        static let textEditorBorderColor: Color = Color(.systemGray6)
        static let textEditorBorderWidth: CGFloat = 2
    }
    
    //MARK: - Properties
    @EnvironmentObject var viewModel: MedicationReminderViewModel
    @State private var medicine: String = ""
    @State private var dosage: String = ""
    @State private var date: Date = Date()
    @State private var frequency: Frequency = Frequency.day
    @State private var time: Date = Date()
    @State private var afterMeal: MealTime = MealTime.beforeMeal
    @State private var descpription: String = ""
    @State private var isTimeDisplayed: Bool = false
    @Binding var isSheetPresented: Bool
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Medicine")
                    Spacer()
                    TextField("Enter medicine name...", text: self.$medicine)
                        .frame(width: Parameters.textfieldWidth, alignment: .trailing)
                }
                .padding(.horizontal, Parameters.horizontalPadding)
                .padding(.vertical, Parameters.verticalPadding)
                HStack {
                    Text("Dosage")
                    Spacer()
                    TextField("Enter medicine dosage...", text: self.$dosage)
                        .frame(width: Parameters.textfieldWidth, alignment: .trailing)
                }
                .padding(.horizontal, Parameters.horizontalPadding)
                .padding(.vertical, Parameters.verticalPadding)
                VStack {
                    Text("Start Date")
                        .padding(.horizontal, Parameters.horizontalPadding)
                        .padding(.top, Parameters.verticalPadding)
                    DatePicker("", selection: self.$date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .padding(.horizontal, Parameters.horizontalPadding)
                        .padding(.vertical, Parameters.verticalPadding)
                }
                Picker("", selection: self.$frequency) {
                    ForEach(Frequency.allCases) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, Parameters.horizontalPadding)
                .padding(.vertical, Parameters.verticalPadding)
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: Parameters.iconWidth, height: Parameters.iconWidth)
                        .foregroundColor(Parameters.buttonColor)
                    Text("Time")
                        .padding(.leading, Parameters.verticalPadding)
                }
                .onTapGesture {
                    self.isTimeDisplayed = true
                }
                .padding(.horizontal, Parameters.horizontalPadding)
                if self.isTimeDisplayed {
                    DatePicker("", selection: self.$time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .padding(.horizontal, Parameters.horizontalPadding)
                        .padding(.vertical, Parameters.verticalPadding)
                }
                Picker("", selection: self.$afterMeal) {
                    ForEach(MealTime.allCases) { time in
                        Text(time.rawValue)
                            .tag(time)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, Parameters.horizontalPadding)
                .padding(.vertical, Parameters.verticalPadding)
                TextEditor(text: self.$descpription)
                    .frame(height: Parameters.textEditorHeight)
                    .font(.body)
                    .border(Parameters.textEditorBorderColor, width: Parameters.textEditorBorderWidth)
                    .padding(.horizontal, Parameters.horizontalPadding)
            }
            .listStyle(.plain)
            .padding(.top, Parameters.listPaddingTop)
            .toolbar(content: {
                HStack {
                    Button("Dismiss") {
                        self.isSheetPresented = false
                    }
                    Button("Save") {
                        self.viewModel.createReminder(medicine: self.medicine, dosage: self.dosage, date: self.date, frequency: self.frequency.rawValue, time: self.time, afterMeal: self.afterMeal.rawValue, description: self.descpription)
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
