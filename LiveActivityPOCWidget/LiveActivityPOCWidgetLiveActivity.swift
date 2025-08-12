import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityPOCWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var picpayLogo: String = "PicPay"
        var text: String = "Proteja seu celular e garanta 20% de cashback"
        var progress: Double
        var labels: [String] = ["Seguro contratado", "Apólice emitida", "Cashback liberado"]
        var seconds: Int = 0
    }

    var name: String
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
                            Text(timeString(from: context.state.seconds))
                                .font(.caption)
                        }
                    }
                    Spacer()
                    HStack {
                        Text("Seu celular ainda está sem proteção")
                            .font(.system(size: 14))
                        Image(systemName: "shield")
                            .font(.system(size: 14))
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(colors: [Color(red: 0, green: 0.56, blue: 0.41), Color(red: 0.05, green: 1.61, blue: 1.19)], startPoint: .leading, endPoint: .trailing))
                            .frame(minHeight: 60)
                        Text("Ganhe R$20 de cashback + cobertura contra roubo, furto e quebra. Apenas R$ 2,00 por dia")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(10)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 1)
                    Text("Evite prejuízo de até R$7.000")
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
                        Text(timeString(from: context.state.seconds))
                            .font(.caption)
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
                            Text("Ganhe R$20 de cashback + cobertura contra roubo, furto e quebra. Apenas R$ 2,00 por dia")
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
                    Text(timeString(from: context.state.seconds))
                        .font(.caption)
                }
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

func timeString(from seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let secs = seconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, secs)
}
