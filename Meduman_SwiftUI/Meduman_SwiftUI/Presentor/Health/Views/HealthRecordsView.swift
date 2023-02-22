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
    @EnvironmentObject var healthModel: HealthRecordViewModel
    @State private var isPresented = false
    
    //MARK: - Lifecycles
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(self.healthModel.records, id: \.id) { record in
                        RecordCellView(sampleRecord: record)
                    }
                    .onDelete { indexSet in
                        self.healthModel.removeRecord(indexSet: indexSet)
                    }
                }
                    .accessibilityIdentifier("recordsList")
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
                .accessibilityIdentifier("createRecordSheet")
        }
    }
}

struct HealthRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRecordsView()
    }
}
