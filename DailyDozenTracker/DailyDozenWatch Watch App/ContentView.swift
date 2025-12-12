//
//  ContentView.swift
//  DailyDozenWatch Watch App
//
//  Created by Cael McDermott on 10/21/25.
//

import SwiftUI

struct ContentView: View {
    // ⚠️ IMPORTANT: This line assumes you fixed the data file by removing @State
    @State var checklist = dailyDozenChecklist

    // The "Calculator" that turns completed items into a number between 0.0 and 1.0
    var progressPercentage: Double {
        let completedCount = checklist.filter { $0.isComplete }.count
        let totalCount = checklist.count
        return Double(completedCount) / Double(totalCount)
    }

    // The text display (e.g., "1/12")
    var displayProgress: String {
        let completedCount = checklist.filter { $0.isComplete }.count
        let totalCount = checklist.count
        return "\(completedCount)/\(totalCount)"
    }

    var body: some View {
            
            // ZStack layers the circle, the arc, and the text on top of each other
            ZStack {
                
                // 1. BACKGROUND RING (The gray track)
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 10)
                
                // 2. PROGRESS ARC (The filling green part)
                Circle()
                    .trim(from: 0.0, to: progressPercentage) // Uses your calculated percentage
                    .stroke(
                        Color.green,
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90)) // Starts the fill at the top (12 o'clock)
                    .animation(.linear(duration: 0.5), value: progressPercentage)
                
                // 3. TEXT IN THE MIDDLE
                Text(displayProgress)
                    .font(.title3) // Smaller font for the watch
                    .foregroundColor(.white)
            }
            .padding() // Adds padding around the circle
            
            // 🚨 CRITICAL: This loads the latest data from the iPhone every time the view is shown
            .onAppear {
                if let updatedList = loadChecklist() {
                    checklist = updatedList
                }
            }
        }
    }
