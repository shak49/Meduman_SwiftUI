//
//  RecordCellView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/20/23.
//

import SwiftUI
import HealthKit

struct RecordCellView: View {
    //MARK: - Properties
    var sampleRecord: HKQuantitySample?
    
    //MARK: - Body
    var body: some View {
        if let sampleRecord = sampleRecord {
            VStack(alignment: .leading) {
                Text("\(sampleRecord.quantity)")
                    .font(.title3)
                Spacer()
                HStack {
                    Text("\(sampleRecord.endDate.formatted(date: .numeric, time: .omitted))")
                        .foregroundColor(Color(.systemBlue))
                        .font(.caption)
                        .padding(3)
                        .border(Color(.systemBlue), width: 1)
                    Text(sampleRecord.sampleType == HKQuantityType.quantityType(forIdentifier: .bloodGlucose) ? "BLOOD GLUCOSE" : sampleRecord.sampleType == HKQuantityType.quantityType(forIdentifier: .heartRate) ? "HEART RATE" : "BLOOD PRESSURE")
                        .foregroundColor(Color(.systemOrange))
                        .font(.caption)
                        .padding(3)
                        .border(Color(.systemOrange), width: 1)
                }
            }
            .padding(.leading, 32)
            .onTapGesture(perform: {
                print("GESTURE")
            })
        }
    }
}

struct RecordCellView_Previews: PreviewProvider {
    static var previews: some View {
        RecordCellView()
    }
}
