//
//  CreateRecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/19/23.
//

import SwiftUI


enum MealTime: String {
    case beforeMeal = "Before Meal"
    case afterMeal = "After Meal"
}

enum RecordView: String {
    case bloodGlucose = "Blood Glucose"
    case heartRate = "Heart Rate"
    case bloodPressure = "Blood Pressure"
}

struct CreateRecordView: View {
    //MARK: - Properties
    @EnvironmentObject private var model: HealthRecordViewModel
    @Binding var isPresented: Bool
    @State private var recordView = RecordView.bloodGlucose
    @State private var record = 0.0
    @State private var dateAndTime = Date()
    @State private var mealTime = MealTime.beforeMeal
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("Record View", selection: self.$recordView) {
                    Text(RecordView.bloodGlucose.rawValue)
                        .tag(RecordView.bloodGlucose)
                        .padding(10)
                    Text(RecordView.heartRate.rawValue)
                        .tag(RecordView.heartRate)
                        .padding(10)
                    Text(RecordView.bloodPressure.rawValue)
                        .tag(RecordView.bloodPressure)
                        .padding(10)
                }
                    .pickerStyle(.segmented)
                    .cornerRadius(7)
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                if recordView == .bloodGlucose {
                    BloodGlucoseView(mealTime: self.$mealTime, record: self.$record, dateAndTime: self.$dateAndTime)
                } else if recordView == .heartRate {
                    
                } else {
                    
                }
                Spacer()
            }
                .navigationTitle(Text("Record"))
                .toolbar {
                    HStack {
                        Button("Dismiss") {
                            self.isPresented = false
                        }
                        Button("Create") {
                            if recordView == .bloodGlucose {
                                self.model.createBloodGlucose(record: self.record, dateAndTime: self.dateAndTime, mealTime: self.mealTime.rawValue)
                                self.isPresented = false
                            } else if recordView == .heartRate {
                                
                            } else {
                                
                            }
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
