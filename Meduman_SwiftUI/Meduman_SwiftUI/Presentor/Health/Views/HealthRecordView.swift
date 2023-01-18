//
//  RecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/4/22.
//

import SwiftUI
import HealthKit


struct HealthRecordView: View {
    //MARK: - Properties
    static var healthStore = HKHealthStore()
    static var healthQuery: HKSampleQuery?
    static var repo = HealthRepository(healthStore: healthStore, healthQuery: healthQuery)
    var useCase = HealthUseCase(repo: repo)
    @ObservedObject private var model: HealthRecordViewModel
    @State private var isPresented = false
    @State private var bloodGlucoseRecord = ""
    
    //MARK: - Lifecycles
    init() {
        self.model = HealthRecordViewModel(useCase: useCase)
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
                    RecordCreationPopupView()
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
