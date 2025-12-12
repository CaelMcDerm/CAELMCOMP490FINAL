//
//  AppGroupTracker.swift
//  DailyDozenTracker
//
//  Created by Cael McDermott on 10/21/25.
//

import Foundation

// ⚠️ IMPORTANT: This line MUST match the App Group ID you created: group.McDermottC.DailyDozen
let sharedAppGroup = "group.McDermottC.DailyDozen"
let defaults = UserDefaults(suiteName: sharedAppGroup)

// ---------------------------------------------------------------------
// MARK: - Saving (Called by iPhone)
// ---------------------------------------------------------------------

func saveChecklist(list: [DailyDozenItem]) {
    guard let defaults = defaults else { return }
    do {
        // Encodes the Swift list into safe, savable Data format
        let encodedData = try JSONEncoder().encode(list)
        defaults.set(encodedData, forKey: "DailyDozenKey")
        print("Checklist saved successfully.")
    } catch {
        print("Error saving list: \(error)")
    }
}

// ---------------------------------------------------------------------
// MARK: - Loading (Called by Watch)
// ---------------------------------------------------------------------

func loadChecklist() -> [DailyDozenItem]? {
    // 1. Check the shared mailbox for saved data
    guard let defaults = defaults,
          let savedData = defaults.data(forKey: "DailyDozenKey") else {
        return nil // No saved data found
    }
    
    // 2. Decode the saved Data back into a Swift array
    do {
        return try JSONDecoder().decode([DailyDozenItem].self, from: savedData)
    } catch {
        print("Error loading list: \(error)")
        return nil
    }
}
