import UIKit
import ActivityKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 16.1, *) {
            startLiveActivity()
        }
    }

    func startLiveActivity() {
        let attributes = LiveActivityPOCWidgetAttributes(name: "Widget")
        let initialState = LiveActivityPOCWidgetAttributes.ContentState(emoji: "🔴")

        do {
            let activity = try Activity<LiveActivityPOCWidgetAttributes>.request(
                attributes: attributes,
                contentState: initialState,
                pushType: nil
            )
            print("Live Activity iniciada: \(activity.id)")

            Task {
                try? await Task.sleep(nanoseconds: 10_000_000_000)
                await updateLiveActivity(activity: activity)
            }

        } catch {
            print("Erro ao iniciar Live Activity: \(error.localizedDescription)")
        }
    }
    
    func updateLiveActivity(activity: Activity<LiveActivityPOCWidgetAttributes>) async {
        let updatedState = LiveActivityPOCWidgetAttributes.ContentState(emoji: "✅")

        await activity.update(using: updatedState)
    }

}

