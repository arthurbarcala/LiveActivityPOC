import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityPOCWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var picpayLogo: String = "PicPay"
        var text: String = "Proteja seu celular e garanta 20% de cashback"
        var progress: Double
        var labels: [String] = ["Seguro contratado", "Apólice emitida", "Cashback liberado"]
    }

    var name: String
}

struct LiveActivityPOCWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityPOCWidgetAttributes.self) { context in
            VStack {
                HStack {
                    Text(context.state.picpayLogo)
                        .bold()
                        .padding(20)
                    Spacer()
                }
                Text(context.state.text)
                    
                ZStack(alignment: .leading) {
                        ProgressView(value: context.state.progress, total: 100)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                            .frame(height: 8)
                            .padding(.horizontal, 60)
                        HStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 12, height: 12)
                            Spacer()
                            Circle()
                                .fill(Color.green)
                                .frame(width: 12, height: 12)
                            Spacer()
                            Circle()
                                .fill(Color.green)
                                .frame(width: 12, height: 12)
                        }
                        .padding(.horizontal, 60)
                    }
                    .padding(.vertical, 8)
                HStack {
                    Text(context.state.labels[0])
                        .font(.caption)
                        .padding(5)
                    Text(context.state.labels[1])
                        .font(.caption)
                        .padding(5)
                    Text(context.state.labels[2])
                        .font(.caption)
                        .padding(5)
                }
                Spacer()
            }
            .activityBackgroundTint(Color.white)
            .activitySystemActionForegroundColor(Color.gray)

        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Text(context.state.picpayLogo)
                            .bold()
                            .padding(20)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        ZStack(alignment: .leading) {
                            ProgressView(value: context.state.progress, total: 100)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                                .frame(height: 8)
                                .padding(.horizontal, 60)
                            HStack {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 12, height: 12)
                                Spacer()
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 12, height: 12)
                                Spacer()
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 12, height: 12)
                            }
                            .padding(.horizontal, 60)
                        }
                        .padding(.vertical, 8)
                        HStack {
                            Text(context.state.labels[0])
                                .font(.caption)
                                .padding(5)
                            Text(context.state.labels[1])
                                .font(.caption)
                                .padding(5)
                            Text(context.state.labels[2])
                                .font(.caption)
                                .padding(5)
                        }
                        Spacer()
                    }
                }
            } compactLeading: {
                    Text("P")
                    .bold()
                    .padding(10)
                    .background(Color.green)
                    .cornerRadius(24)
            } compactTrailing: {
                ProgressView(value: context.state.progress, total: 100)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.green))
            } minimal: {
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
    static var seguroContratado: LiveActivityPOCWidgetAttributes.ContentState {
        LiveActivityPOCWidgetAttributes.ContentState(progress: 0)
     }
    
    static var apoliceEmitida: LiveActivityPOCWidgetAttributes.ContentState {
        LiveActivityPOCWidgetAttributes.ContentState(progress: 50)
    }
     
    static var cashbackLiberado: LiveActivityPOCWidgetAttributes.ContentState {
         LiveActivityPOCWidgetAttributes.ContentState(progress: 100)
     }
}

#Preview("Notification", as: .content, using: LiveActivityPOCWidgetAttributes.preview) {
   LiveActivityPOCWidgetLiveActivity()
} contentStates: {
    LiveActivityPOCWidgetAttributes.ContentState.seguroContratado
    LiveActivityPOCWidgetAttributes.ContentState.apoliceEmitida
    LiveActivityPOCWidgetAttributes.ContentState.cashbackLiberado
}


