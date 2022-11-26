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
    @ObservedObject private var model: HealthRecordViewModel
    static var healthStore = HKHealthStore()
    static var repo = HealthRepository(healthStore: healthStore)
    var manager = HealthManager(repo: repo)
    
    //MARK: - Lifecycles
    init() {
        self.model = HealthRecordViewModel(manager: manager)
    }
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .onAppear(perform: authorize)
        }
        .navigationTitle(Text("Health Records"))
    }
    
    func authorize() {
        model.authorize()
    }
}

struct HealthRecordView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRecordView()
    }
}
