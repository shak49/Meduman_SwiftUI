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
                List {
                    ForEach(self.model.records, id: \.uuid) { record in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(record.quantity)")
                                Spacer()
                                HStack {
                                    Text("\(record.startDate.formatted(date: .numeric, time: .omitted))")
                                    Text("\(record.endDate.formatted(date: .numeric, time: .omitted))")
                                }
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            }
                            Spacer()
                            Rectangle()
                                .frame(width: 5, height: 50)
                                .foregroundColor(Color(.systemRed))
                        }
                        .padding(.leading, 15)
                    }
                }
                .listStyle(.inset)
                .padding(.top, 32)
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
