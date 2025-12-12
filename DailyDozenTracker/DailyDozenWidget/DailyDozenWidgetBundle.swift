//
//  DailyDozenWidgetBundle.swift
//  DailyDozenWidget
//
//  Created by Cael McDermott on 12/2/25.
//

import WidgetKit
import SwiftUI

@main
struct DailyDozenWidgetBundle: WidgetBundle {
    var body: some Widget {
        DailyDozenWidget()
        DailyDozenWidgetControl()
        DailyDozenWidgetLiveActivity()
    }
}
