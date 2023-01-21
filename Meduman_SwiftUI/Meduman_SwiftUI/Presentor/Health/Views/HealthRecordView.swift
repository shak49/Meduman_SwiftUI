//
//  RecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/4/22.
//

import SwiftUI
import HealthKit
import XCTest


struct HealthRecordView: View {
    //MARK: - Properties
    static var healthStore = HKHealthStore()
    static var healthQuery: HKSampleQuery?
    static var repo = HealthRepository(healthStore: healthStore, healthQuery: healthQuery)
    var useCase = HealthUseCase(repo: repo)
    @ObservedObject private var model: HealthRecordViewModel
    @State private var isPresented = false
    
    //MARK: - Lifecycles
    init() {
        self.model = HealthRecordViewModel(useCase: useCase)
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            Text("HEALTH RECORD VIEW")
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
        }
    }
}

struct HealthRecordView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRecordView()
    }
}
