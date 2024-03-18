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
    @StateObject var vm = HomeVM()
    
    //MARK: - Body
    var body: some View {
        VStack {
            if vm.isRecordsAvailable {
                GroupBox("Daily Progress") {
                    Chart {
                        ForEach(vm.dataLines) { dataLine in
                            ForEach(dataLine.samples) { sample in
                                LineMark(
                                    x: .value("date", sample.date),
                                    y: .value("record", sample.quantity)
                                )
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(by: .value("type", sample.type))
                            }
                        }
                    }
                    .frame(height: 200)
                    .chartLegend(position: .bottom, alignment: .center, spacing: 16)
                }
            }
            ArticleListView(vm: vm)
        }
    }
}

#Preview {
    HomeView()
}

