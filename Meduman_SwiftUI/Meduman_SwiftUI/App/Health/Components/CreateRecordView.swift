//
//  CreateRecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 1/19/23.
//

import SwiftUI


enum HealthType: String, CaseIterable, Identifiable {
    case bloodGlucose = "Blood Glucose"
    case heartRate = "Heart Rate"
    case bloodPressure = "Blood Pressure"
    
    var id: String { self.rawValue }
}

struct CreateRecordView: View {
    //MARK: - Properties
    @EnvironmentObject var healthModel: HealthRecordViewModel
    @Binding var isPresented: Bool
    @State private var record = 0.0
    @State private var dateAndTime = Date()
    @State private var healthType = HealthType.bloodGlucose
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("Health Type Record", selection: self.$healthType) {
                    ForEach(HealthType.allCases) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                    .accessibilityIdentifier("healthTypeSegment")
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 32)
                    .padding(.top, 64)
                TextField("Enter a new record...", value: self.$record, format: .number)
                    .frame(height: 35)
                    .foregroundColor(.gray)
                    .background(Color(.systemGray6))
                    .cornerRadius(7)
                    .padding(.horizontal, 32)
                    .padding(.top, 8)
                    .accessibilityIdentifier("recordTextField")
                DatePicker("", selection: self.$dateAndTime)
                    .pickerStyle(.menu)
                    .frame(height: 35)
                    .cornerRadius(7)
                    .padding(.horizontal, 32)
                    .padding(.top, 8)
                    .accessibilityIdentifier("recordDatePicker")
                Spacer()
            }
                .navigationTitle(Text("Record"))
                .toolbar {
                    HStack {
                        Button("Dismiss") {
                            self.isPresented = false
                        }
                        Button("Create") {
                            if healthType == .bloodGlucose {
                                self.healthModel.createBloodGlucose(record: self.record, dateAndTime: self.dateAndTime)
                            } else if healthType == .heartRate {
                                self.healthModel.createHeartRate(record: self.record, dateAndTime: self.dateAndTime)
                            } else {
                                self.healthModel.createBloodPressure(record: self.record, dateAndTime: self.dateAndTime)
                            }
                            self.isPresented = false
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
