//
//  RecordView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 9/4/22.
//

import SwiftUI
import HealthKit

struct HealthRecordView: View {
    @ObservedObject private var model: HealthViewModel
    static let healthRepo: HealthRepository? = HealthRepository()
    static let manager: HealthManager? = HealthManager(healthRepo: healthRepo)
    
    init(manager: HealthManager? = manager) {
        self.model = HealthViewModel(manager: manager)
    }
    
    var body: some View {
        VStack {
            
        }
        .onAppear(perform: model.authorize)
    }
}

struct HealthRecordView_Previews: PreviewProvider {
    static var previews: some View {
        HealthRecordView()
    }
}
