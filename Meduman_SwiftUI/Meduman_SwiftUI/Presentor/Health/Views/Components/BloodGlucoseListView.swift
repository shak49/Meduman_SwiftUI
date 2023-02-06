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
    
    var body: some View {
        List(self.healthModel.records, id: \.uuid) { record in
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
            .padding(.leading, 15)
        }
        .listStyle(.insetGrouped)
    }
}

struct BloodGlucoseListView_Previews: PreviewProvider {
    static var previews: some View {
        BloodGlucoseListView()
    }
}
