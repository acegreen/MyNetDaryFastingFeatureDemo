//
//  DashboardingFastingView-ALT.swift
//  MyNetDiaryFastingDemo
//
//  Created by Ace Green on 2023-08-06.
//

import SwiftUI

struct DashboardingFastingView_ALT: View {
    @State private var fast: Fast = .eighteen
    @State private var startDate: Date = Self.now
    @State private var endDate: Date = Self.now
    private static var now = Date()
    @State var longestDate: Date = Date().addingTimeInterval(79 * 60 * 60)

    @State private var showFastGoalSheet = false
    @State private var showStartDatePickerSheet = false
    @State private var showEndDatePickerSheet = false
    @State private var isFasting = false
    @State private var progress: Double = 0.0

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "timer")
                        .imageScale(.large)
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
                    VStack(spacing: 16) {
                        VStack(alignment: .center, spacing: 4) {
                            Text("LONGEST FAST")
                                .font(.system(size: 10))
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
                            Text("AVG FAST")
                                .font(.system(size: 10))
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
                            Text("CALENDAR")
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            NavigationLink {
                                CalendarView(calendar: .current)
                            } label: {
                                Image(systemName: "calendar.badge.clock")
                                    .imageScale(.large)
                                    .foregroundStyle(.green)
                            }
                        }
                        .hSpacing(.center)
                    }
                    CircularProgressView(label: {
                        Text("Elapsed (\(progress.formatted(.percent.precision(.fractionLength(0)))))")
                            .font(.caption)
                            .foregroundStyle(.gray)
                            .bold()
                    }, currentValueLabel: {
                        Text(isFasting ? startDate : endDate, style: .timer)
                            .font(.title2)
                            .bold()
                    }, progress: progress)
                    .frame(width: 150, height: 150)
                    VStack(spacing: 16) {
                        VStack(alignment: .center, spacing: 4) {
                            Text("AVG Ketosis")
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            Text("0.7 mmol/L")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(.black)
                                .lineLimit(1)
                        }
                        .hSpacing(.center)
                        VStack(alignment: .center, spacing: 4) {
                            Text("AVG Glucose")
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            Text("4.2 mmol/L")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(.black)
                        }
                        .hSpacing(.center)

                        VStack(alignment: .center, spacing: 4) {
                            Text("AVG Sleep")
                                .font(.system(size: 10))
                                .fontWeight(.medium)
                                .foregroundStyle(.gray)
                            Text("6h 2m")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(.black)
                                .lineLimit(1)
                        }
                        .hSpacing(.center)
                    }
                }
                .hSpacing(.center)
                HStack(alignment: .center) {
                    if isFasting {
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
                            .onChange(of: startDate, perform: { value in
                                setFast(fast)
                            })
                        }
                        .hSpacing(.center)
                    }
                    Button {
                        isFasting.toggle()
                        startDate = Date.now
                        setFast(fast)
                    } label: {
                        Text(isFasting ? "End Fasting" : "Start Fasting")
                            .frame(minWidth: 120)
                            .font(.callout)
                            .fontWeight(.medium)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .cornerRadius(24)
                    .padding()
                    if isFasting {
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
                                VStack {
                                    FastGridView(callback: setFast)
                                }
                                .padding()
                                .presentationDetents([.medium])
                            }
                        }
                        .hSpacing(.center)
                    }
                }
            }
        }
        .onAppear {
            endDate = fast.goal(from: startDate)
        }
        .padding()
    }

    func setFast(_ fast: Fast) {
        self.fast = fast
        resetProgress()
    }

    func resetProgress() {
        progress = calculateProgress()
        endDate = fast.goal(from: startDate)
    }

    func calculateProgress() -> Double {
        let currentInterval = Date.now.timeIntervalSinceReferenceDate
        let startInterval = startDate.timeIntervalSinceReferenceDate
        let endInterval = endDate.timeIntervalSinceReferenceDate
        return ((currentInterval - startInterval) / (endInterval - startInterval))
    }
}

#Preview {
    DashboardingFastingView_ALT()
        .previewLayout(.sizeThatFits)
}
