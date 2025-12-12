//
//  DailyDozenWidget.swift
//  DailyDozenWidget
//
//  Created by Cael McDermott on 12/2/25.
//

import WidgetKit
import SwiftUI
import Foundation

// MARK: - 1. Widget Data Struct
struct SimpleEntry: TimelineEntry {
    let date: Date
    let progress: Double
    let progressText: String
}

// MARK: - 2. Provider (Data Fetcher)
struct Provider: TimelineProvider {
    
    func getProgress() -> (Double, String) {
        // These functions are available because the files are linked above
        let list = loadChecklist() ?? dailyDozenChecklist
        let completedCount = list.filter { $0.isComplete }.count
        let totalCount = list.count
        
        guard totalCount > 0 else { return (0.0, "0/12") }
        
        let percentage = Double(completedCount) / Double(totalCount)
        let text = "\(completedCount)/\(totalCount)"
        return (percentage, text)
    }

    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), progress: 0.5, progressText: "6/12")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let (progress, text) = getProgress()
        let entry = SimpleEntry(date: Date(), progress: progress, progressText: text)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let (progress, text) = getProgress()
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: Date())!
        
        let entry = SimpleEntry(date: Date(), progress: progress, progressText: text)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

// MARK: - 3. Widget View (The Lock Screen Display)
struct DailyDozenProgressWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Gauge(value: entry.progress) {
            Text(entry.progressText)
                .font(.caption2)
        }
        .gaugeStyle(.accessoryCircular) // Lock Screen Circular Style
        .tint(.green)
    }
}

// MARK: - 4. Widget Definition (Omitting @main to prevent conflict)
struct DailyDozenWidget: Widget {
    let kind: String = "DailyDozenWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyDozenProgressWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Dozen Progress")
        .description("Track your daily progress at a glance.")
        .supportedFamilies([.accessoryCircular])
    }
}
