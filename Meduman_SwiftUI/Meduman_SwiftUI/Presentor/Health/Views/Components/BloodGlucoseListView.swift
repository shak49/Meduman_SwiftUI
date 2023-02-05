//
//  BloodGlucoseListView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/4/23.
//

import SwiftUI
import HealthKit


struct BloodGlucoseListView: View {
    //MARK: - Properties
    @EnvironmentObject private var healthModel: HealthRecordViewModel
    let bloodGlucoseSample = HKSampleType.quantityType(forIdentifier: .bloodGlucose)
    
    var body: some View {
        List(self.healthModel.records, id: \.uuid) { record in
            Text("\(record)")
        }
        .onAppear(perform: readRecords)
    }
    
    func readRecords() {
        self.healthModel.readRecord(type: bloodGlucoseSample)
    }
}

struct BloodGlucoseListView_Previews: PreviewProvider {
    static var previews: some View {
        BloodGlucoseListView()
    }
}
