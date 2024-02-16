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
            Section("Latest Reminder") {
                ZStack {
                    Button {

                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(vm.reminders.last?.medicine ?? "")
                                    .font(.system(size: 24))
                                Capsule()
                                    .frame(width: 85, height: 20)
                                    .foregroundColor(vm.reminders.last?.mealTime == "After Meal" ? .systemOrange : .systemBlue)
                                    .overlay {
                                        Text(vm.reminders.last?.mealTime ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 12))
                                            .padding(5)
                                    }
                            }
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 76, height: 76)
                                .foregroundColor(Color(.systemGray4))
                                .overlay {
                                    Text("00:00")
                                        .frame(width: 50, alignment: .center)
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .frame(width: 400, height: 100)
                .ignoresSafeArea()
                .background(Color.placeholder)
            }
            .frame(alignment: .leading)
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}

