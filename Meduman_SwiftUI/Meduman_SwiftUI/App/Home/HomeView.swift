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
                ForEach(vm.records.sorted { $0.key < $1.key }, id: \.key) { key, value in
                    ForEach(value) { sample in
                        LineMark(x: .value("date", sample.endDate), y: .value("record", sample.quantity))
                            .foregroundStyle(by: .value("type", key))
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .year)) { _ in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.year(.defaultDigits))
                }
            }
                .frame(height: 200)
            Rectangle()
                .frame(height: 200)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeView()
}

