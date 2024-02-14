//
//  HomeView.swift
//  Meduman_SwiftUI
//
//  Created by Shak Feizi on 2/6/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    //MARK: - Properties
    @ObservedObject var vm = HomeVM()
    
    //MARK: - Body
    var body: some View {
        VStack {
            Chart {
                ForEach(vm.records.sorted { $0.key < $1.key }, id: \.key) { type, samples in
                    ForEach(samples.sorted { $0.quantity < $1.quantity }) { sample in
                        LineMark(x: .value("date", sample.endDate), y: .value("record", sample.quantity))
                            .foregroundStyle(by: .value("type", type))
                    }
                }
            }
                .frame(height: 200)
                .chartLegend(position: .bottom, alignment: .center, spacing: 16)
            Rectangle()
                .frame(height: 200)
                .foregroundColor(.placeholder)
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}

