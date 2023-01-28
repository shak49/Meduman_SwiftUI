//
//  BloodGlucoseView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/28/23.
//

import SwiftUI

struct BloodGlucoseView: View {
    //MARK: - Properties
    var mealTime: Binding<MealTime>
    var record: Binding<String>
    var dateAndTime: Binding<Date>
    
    var body: some View {
        VStack {
            Picker("Meal Time", selection: self.mealTime) {
                Text(MealTime.beforeMeal.rawValue)
                    .tag(MealTime.beforeMeal)
                Text(MealTime.afterMeal.rawValue)
                    .tag(MealTime.afterMeal)
            }
            .pickerStyle(.segmented)
            .cornerRadius(7)
            .padding(.horizontal, 32)
            .padding(.vertical, 4)
            .accessibilityIdentifier("recordSegment")
            TextField("Enter a new record...", text: self.record)
                .frame(height: 35)
                .background(Color(.systemGray6))
                .cornerRadius(7)
                .padding(.horizontal, 32)
                .padding(.vertical, 4)
                .accessibilityIdentifier("recordTextField")
            DatePicker("", selection: self.dateAndTime)
                .pickerStyle(.menu)
                .frame(height: 35)
                .cornerRadius(7)
                .padding(.horizontal, 32)
                .padding(.vertical, 4)
                .accessibilityIdentifier("recordDatePicker")
        }
        .padding(.top, 64)
    }
}

struct BloodGlucoseView_Previews: PreviewProvider {
    static var previews: some View {
        BloodGlucoseView(mealTime: .constant(.beforeMeal), record: .constant(""), dateAndTime: .constant(Date.now))
    }
}
