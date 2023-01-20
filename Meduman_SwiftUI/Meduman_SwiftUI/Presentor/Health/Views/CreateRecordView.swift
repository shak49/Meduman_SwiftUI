//
//  CreateRecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/19/23.
//

import SwiftUI


enum Meal: String {
    case beforeMeal = "Before Meal"
    case afterMeal = "After Meal"
}

struct CreateRecordView: View {
    //MARK: - Properties
    @Binding var isPresented: Bool
    @State private var record = ""
    @State private var date = Date()
    @State private var mealTime = Meal.beforeMeal
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("Choose one", selection: self.$mealTime) {
                    Text(Meal.beforeMeal.rawValue)
                        .tag(Meal.beforeMeal)
                    Text(Meal.afterMeal.rawValue)
                        .tag(Meal.afterMeal)
                }
                .pickerStyle(.segmented)
                .cornerRadius(7)
                .padding(.horizontal, 32)
                .padding(.vertical, 4)
                .accessibilityIdentifier("recordSegment")
                TextField("Enter a new record...", text: self.$record)
                    .frame(height: 35)
                    .background(Color(.systemGray6))
                    .cornerRadius(7)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 4)
                    .accessibilityIdentifier("recordTextField")
                DatePicker("", selection: self.$date)
                    .pickerStyle(.menu)
                    .frame(height: 35)
                    .cornerRadius(7)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 4)
                    .accessibilityIdentifier("recordDatePicker")
            }
                .padding(.top, 32)
                .padding(.bottom, 350)
                .navigationTitle(Text("Record"))
                .toolbar {
                    HStack {
                        Button("Dismiss") {
                            self.isPresented = false
                        }
                        Button("Create") {
                            
                        }
                        .accessibilityIdentifier("createButton")
                    }
                }
        }
    }
}

struct CreateRecordView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecordView(isPresented: .constant(false))
    }
}
