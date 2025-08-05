import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityPOCWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var emoji: String
    }

    var name: String
}

struct LiveActivityPOCWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityPOCWidgetAttributes.self) { context in
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
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
    fileprivate static var smiley: LiveActivityPOCWidgetAttributes.ContentState {
        LiveActivityPOCWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: LiveActivityPOCWidgetAttributes.ContentState {
         LiveActivityPOCWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: LiveActivityPOCWidgetAttributes.preview) {
   LiveActivityPOCWidgetLiveActivity()
} contentStates: {
    LiveActivityPOCWidgetAttributes.ContentState.smiley
    LiveActivityPOCWidgetAttributes.ContentState.starEyes
}
