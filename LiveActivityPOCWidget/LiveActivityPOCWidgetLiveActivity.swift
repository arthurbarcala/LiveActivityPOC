import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityPOCWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var picpayLogo: String = "PicPay"
        var texts: [String]?
        var seconds: Double = 0
    }

    var name: String = "Widget"
}

struct LiveActivityPOCWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveActivityPOCWidgetAttributes.self) { context in
            VStack(spacing: 8) {
                Spacer()
                VStack(alignment: .leading) {
                    HStack(spacing: 4) {
                        Text("PicPay")
                            .bold()
                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                                .font(.caption)
                            Text(
                                timerInterval: Date.now...Date(timeInterval: context.state.seconds, since: .now),
                                pauseTime: Date.now,
                                countsDown: true,
                                showsHours: true
                            )
                            .font(.caption)
                            .frame(width: 50)
                        }
                    }
                    Spacer()
                    HStack {
                        Text(context.state.texts?[0] ?? "")
                            .font(.system(size: 14))
                        Image(systemName: "shield")
                            .font(.system(size: 14))
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [Color(red: 0, green: 0.56, blue: 0.41), Color(red: 0.05, green: 1.61, blue: 1.19)], startPoint: .leading, endPoint: .trailing))
                            .frame(minHeight: 60)
                        Text(context.state.texts?[1] ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 1)
                    Text(context.state.texts?[2] ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 6)
                    Spacer()
                }
                .padding(20)
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    HStack {
                        Text(context.state.picpayLogo)
                            .bold()
                            .padding(12)
                    }
                }
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                        Image(systemName: "clock")
                            .font(.caption)
                        Text(
                            timerInterval: Date.now...Date(timeInterval: context.state.seconds, since: .now),
                            pauseTime: Date.now,
                            countsDown: true,
                            showsHours: true
                        )
                        .font(.caption)
                        .frame(width: 50)
                    }
                    .padding(12)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(colors: [Color(red: 0, green: 0.56, blue: 0.41), Color(red: 0.05, green: 1.61, blue: 1.19)], startPoint: .leading, endPoint: .trailing))
                                .frame(minHeight: 60)
                            Text(context.state.texts?[1] ?? "")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(10)
                                .lineLimit(3)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                    }
                }
            } compactLeading: {
                Text("P")
                    .bold()
                    .padding(6)
                    .background(Color.green)
                    .cornerRadius(24)
            } compactTrailing: {
                HStack {
                    Image(systemName: "clock")
                        .font(.caption)
                    Text(
                        timerInterval: Date.now...Date(timeInterval: context.state.seconds, since: .now),
                        pauseTime: Date.now,
                        countsDown: true,
                        showsHours: true
                    )
                    .font(.caption)
                    .frame(width: 50)
                }
            } minimal: {
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

