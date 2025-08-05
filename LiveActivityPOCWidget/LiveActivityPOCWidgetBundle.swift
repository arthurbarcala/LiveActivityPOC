//
//  LiveActivityPOCWidgetBundle.swift
//  LiveActivityPOCWidget
//
//  Created by Arthur Silva on 04/08/25.
//

import WidgetKit
import SwiftUI

@main
struct LiveActivityPOCWidgetBundle: WidgetBundle {
    var body: some Widget {
        LiveActivityPOCWidget()
        LiveActivityPOCWidgetControl()
        LiveActivityPOCWidgetLiveActivity()
    }
}
