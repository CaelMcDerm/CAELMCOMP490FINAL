//
//  DailyDozenData.swift
//  DailyDozenTracker
//
//  Created by Cael McDermott on 10/21/25.
//

import Foundation

// 1. The blueprint for one item
struct DailyDozenItem: Identifiable, Codable {
    // This lets SwiftUI easily track changes
    let id = UUID()
    let name: String
    var isComplete: Bool = false
}

// 2. The master list of all 12 items
// We use '@State' here so SwiftUI knows to re-draw the screen when this list changes.
var dailyDozenChecklist: [DailyDozenItem] = [
    DailyDozenItem(name: "Beans"),
    DailyDozenItem(name: "Berries"),
    DailyDozenItem(name: "Other Fruits"),
    DailyDozenItem(name: "Cruciferous Veg"),
    DailyDozenItem(name: "Greens"),
    DailyDozenItem(name: "Other Veg"),
    DailyDozenItem(name: "Flaxseeds"),
    DailyDozenItem(name: "Nuts & Seeds"),
    DailyDozenItem(name: "Herbs & Spices"),
    DailyDozenItem(name: "Whole Grains"),
    DailyDozenItem(name: "Beverages"),
    DailyDozenItem(name: "Exercise")
]
