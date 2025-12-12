//
//  ContentView.swift
//  DailyDozenTracker
//
//  Created by Cael McDermott on 10/21/25.
//

import SwiftUI

struct ContentView: View {
    // We use the same list we created in the other file.
    // NOTE: For a real app, you'd make this a more advanced type,
    // but this is the simplest way to get started!
    @State var checklist = dailyDozenChecklist

    var body: some View {
        NavigationView {
            
            // This displays the list of items
            List {
                ForEach(checklist.indices, id: \.self) { index in
                    HStack {
                        // Display the name of the item
                        Text(checklist[index].name)
                        Spacer() // Pushes the checkmark to the right
                        
                        // The button/icon that tracks the item
                        Image(systemName: checklist[index].isComplete ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(checklist[index].isComplete ? .green : .gray)
                            .onTapGesture {
                                // 1. Toggles the checkmark
                                checklist[index].isComplete.toggle()
                                
                                // 2. SAVES the updated list to the shared mailbox!
                                saveChecklist(list: checklist) // <--- THIS LINE IS CRITICAL
                            }
                    }
                }
            }
            .navigationTitle(displayProgress) // Title at the top (e.g., 1/12)
        }
    }
    
    // -----------------------------------------------------
    // The "Calculator" (Code that figures out the numbers)
    // -----------------------------------------------------
    var displayProgress: String {
        let completedCount = checklist.filter { $0.isComplete }.count
        let totalCount = checklist.count
        return "\(completedCount)/\(totalCount) Daily Dozen"
    }
}
