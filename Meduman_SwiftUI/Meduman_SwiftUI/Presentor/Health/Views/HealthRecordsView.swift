//
//  RecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/4/22.
//

import SwiftUI
import HealthKit
import XCTest


enum RecordsView: String {
    case bloodGlucose = "Blood Glucose"
    case heartRate = "Heart Rate"
    case bloodPressure = "Blood Pressure"
}

struct HealthRecordsView: View {
    //MARK: - Properties
    static var healthStore = HKHealthStore()
    static var healthQuery: HKSampleQuery?
    static var repo = HealthRepository(healthStore: healthStore, healthQuery: healthQuery)
    var useCase = HealthUseCase(repo: repo)
    @ObservedObject private var model: HealthRecordViewModel
    @State private var recordsView = RecordsView.bloodGlucose
    @State private var isPresented = false
    
    //MARK: - Lifecycles
    init() {
        self.model = HealthRecordViewModel(useCase: useCase)
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Picker("Records Lists", selection: self.$recordsView) {
                    Text(RecordsView.bloodGlucose.rawValue)
                        .tag(RecordView.bloodGlucose)
                    Text(RecordsView.heartRate.rawValue)
                        .tag(RecordView.heartRate)
                    Text(RecordsView.bloodPressure.rawValue)
                        .tag(RecordView.bloodPressure)
                }
                    .pickerStyle(.segmented)
                    .foregroundColor(.white)
                    .cornerRadius(7)
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                if recordsView == .bloodGlucose {
                    BloodGlucoseListView()
                } else if recordsView == .heartRate {
                    
                } else {
                    
                }
                Spacer()
            }
                .navigationTitle(Text("Health Records"))
                .toolbar(content: {
                    Button {
                        self.isPresented = true
                    } label: {
                        Text("add")
                    }
                    .accessibilityIdentifier("addButton")
                })
                .sheet(isPresented: self.$isPresented, content: {
                    CreateRecordView(isPresented: self.$isPresented)
                })
                .onAppear(perform: model.authorize)
                .accessibilityIdentifier("createRecordSheet")
        }
    }
}

struct HealthRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRecordsView()
    }
}
