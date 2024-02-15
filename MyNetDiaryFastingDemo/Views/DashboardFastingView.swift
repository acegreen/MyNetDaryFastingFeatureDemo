//
//  DashboardFastingView.swift
//  MyNetDiaryFastingDemo
//
//  Created by Ace Green on 2023-08-05.
//

import SwiftUI

struct DashboardFastingView: View {

    @State var fast: Fast = .eighteen
    @State var startDate: Date = try! Date("2023-08-05T18:00:00Z",
                                           strategy: .iso8601)
    @State var endDate: Date = try! Date("2023-08-07T18:00:00Z",
                                         strategy: .iso8601)
    @State var longestDate: Date = Date().addingTimeInterval(79 * 60 * 60)
    @State private var showFastGoalSheet = false
    @State private var showStartDatePickerSheet = false
    @State private var showEndDatePickerSheet = false

    var progress: Double {
        let currentInterval = Date.now.timeIntervalSinceReferenceDate
        let startInterval = startDate.timeIntervalSinceReferenceDate
        let endInterval = endDate.timeIntervalSinceReferenceDate
        return ((currentInterval - startInterval) / (endInterval - startInterval))
    }

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "timer")
                    .font(.title2)
                Text("Fasting")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Button {
                    showFastGoalSheet.toggle()
                } label: {
                    VStack {
                        Text(fast.description)
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .cornerRadius(24)
                .sheet(isPresented: $showFastGoalSheet) {
                    VStack {
                        FastGridView(callback: setFast)
                    }
                    .padding()
                    .presentationDetents([.medium])
                }
            }
            .hSpacing(.leading)
            HStack(alignment: .center, spacing: 16) {
                CircularProgressView(label: {
                    Text("Elapsed (\(progress.formatted(.percent.precision(.fractionLength(0)))))")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .bold()
                }, currentValueLabel: {
                    Text(startDate, style: .timer)
                        .font(.title2)
                        .bold()
                }, progress: progress)
                .frame(width: 150, height: 150)
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        VStack(alignment: .center, spacing: 4) {
                            Text("STARTED")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            Button {
                                showStartDatePickerSheet.toggle()
                            } label: {
                                VStack {
                                    Text(startDate.dashboardDateFormat)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Text(startDate.dashboardHourFormat)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                }
                            }
                            .font(.footnote)
                            .fontWeight(.medium)
                            .buttonStyle(.borderless)
                            .sheet(isPresented: $showStartDatePickerSheet) {
                                DatePicker("Date", selection: $startDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                                    .labelsHidden()
                                    .datePickerStyle(.wheel)
                                    .presentationDetents([.medium])
                            }
                        }
                        .hSpacing(.center)
                        VStack(alignment: .center, spacing: 4) {
                            Text("GOAL")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            Button {
                                showEndDatePickerSheet.toggle()
                            } label: {
                                VStack {
                                    Text(endDate.dashboardDateFormat)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                    Text(endDate.dashboardHourFormat)
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                }
                            }
                            .font(.footnote)
                            .fontWeight(.medium)
                            .buttonStyle(.borderless)
                            .sheet(isPresented: $showEndDatePickerSheet) {
                                DatePicker("Date", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                                    .labelsHidden()
                                    .datePickerStyle(.wheel)
                                    .presentationDetents([.medium])
                            }
                        }
                        .hSpacing(.center)
                    }
                    Button {
                    } label: {
                        VStack {
                            Text("End Fasting")
                                .frame(minWidth: 120)
                                .font(.callout)
                                .fontWeight(.medium)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .cornerRadius(24)
                }
            }
            .hSpacing(.leading)
            .padding()
            HStack {
                VStack(alignment: .center, spacing: 4) {
                    Text("TOTAL FASTS")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Text("489")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .lineLimit(1)
                }
                .hSpacing(.center)
                VStack(alignment: .center, spacing: 4) {
                    Text("LONGEST FAST")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Text(longestDate, style: .relative)
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .lineLimit(1)
                }
                .hSpacing(.center)
                VStack(alignment: .center, spacing: 4) {
                    Text("CURRENT STEAK")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                        .foregroundStyle(.gray)
                    Text("331")
                        .font(.footnote)
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .lineLimit(1)
                }
                .hSpacing(.center)
            }
        }
        .onAppear {
            endDate = fast.goal(from: startDate)
        }
        .padding()
    }

    func setFast(fast: Fast) {
        self.fast = fast
        resetProgress()
    }

    func resetProgress() {
        endDate = fast.goal(from: startDate)
    }
}

#Preview {
    DashboardFastingView()
        .previewLayout(.sizeThatFits)
}
