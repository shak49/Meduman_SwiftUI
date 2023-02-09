//
//  RecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/4/22.
//

import SwiftUI
import HealthKit
import XCTest


struct HealthRecordsView: View {
    //MARK: - Properties
    static var healthStore = HKHealthStore()
    static var healthQuery: HKSampleQuery?
    static var repo = HealthRepository(healthStore: healthStore, healthQuery: healthQuery)
    var useCase = HealthUseCase(repo: repo)
    @ObservedObject var healthModel: HealthRecordViewModel
    @State private var isPresented = false
    
    //MARK: - Lifecycles
    init() {
        self.healthModel = HealthRecordViewModel(useCase: useCase)
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(self.healthModel.records, id: \.uuid) { record in
                        VStack(alignment: .leading) {
                            Text("\(record.quantity)")
                                .font(.title3)
                            Spacer()
                            HStack {
                                Text("\(record.endDate.formatted(date: .numeric, time: .omitted))")
                                    .foregroundColor(Color(.systemBlue))
                                    .font(.caption)
                                    .padding(3)
                                    .border(Color(.systemBlue), width: 1)
                                Text(record.sampleType == HKQuantityType.quantityType(forIdentifier: .bloodGlucose) ? "BLOOD GLUCOSE" : record.sampleType == HKQuantityType.quantityType(forIdentifier: .heartRate) ? "HEART RATE" : "")
                                    .foregroundColor(Color(.systemOrange))
                                    .font(.caption)
                                    .padding(3)
                                    .border(Color(.systemOrange), width: 1)
                            }
                        }
                            .padding(.leading, 32)
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
                .onAppear(perform: healthModel.authorize)
                .accessibilityIdentifier("createRecordSheet")
        }
    }
}

struct HealthRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRecordsView()
    }
}
