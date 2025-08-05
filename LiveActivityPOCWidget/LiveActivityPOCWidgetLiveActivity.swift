import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityPOCWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var emoji: String
        var progress: Double
    }

    var name: String
}

struct LiveActivityPOCWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityPOCWidgetAttributes.self) { context in
            VStack {
                Text("Hello \(context.state.emoji)")
                ProgressView(value: context.state.progress, total: 100.0)
                    .progressViewStyle(.linear)
                    .padding(20)
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    
                }
                DynamicIslandExpandedRegion(.trailing) {
            
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Hello \(context.state.emoji)")
                    ProgressView(value: context.state.progress, total: 100.0)
                        .progressViewStyle(.linear)
                        .padding(20)
                }
            } compactLeading: {
                ProgressView(value: context.state.progress, total: 100.0)
                    .progressViewStyle(.circular)
                    .frame(width: 30)
            } compactTrailing: {
                Text("\(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LiveActivityPOCWidgetAttributes {
    fileprivate static var preview: LiveActivityPOCWidgetAttributes {
        LiveActivityPOCWidgetAttributes(name: "World")
    }
}

extension LiveActivityPOCWidgetAttributes.ContentState {
    static var started: LiveActivityPOCWidgetAttributes.ContentState {
        LiveActivityPOCWidgetAttributes.ContentState(emoji: "🔴", progress: 0)
     }
    
    static var middle: LiveActivityPOCWidgetAttributes.ContentState {
        LiveActivityPOCWidgetAttributes.ContentState(emoji: "💤", progress: 50)
    }
     
    static var finished: LiveActivityPOCWidgetAttributes.ContentState {
         LiveActivityPOCWidgetAttributes.ContentState(emoji: "✅", progress: 100)
     }
}

#Preview("Notification", as: .content, using: LiveActivityPOCWidgetAttributes.preview) {
   LiveActivityPOCWidgetLiveActivity()
} contentStates: {
    LiveActivityPOCWidgetAttributes.ContentState.started
    LiveActivityPOCWidgetAttributes.ContentState.middle
    LiveActivityPOCWidgetAttributes.ContentState.finished
}
