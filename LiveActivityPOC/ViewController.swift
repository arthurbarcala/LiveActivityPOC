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
        let initialState = LiveActivityPOCWidgetAttributes.ContentState.started

        do {
            let activity = try Activity<LiveActivityPOCWidgetAttributes>.request(
                attributes: attributes,
                contentState: initialState,
                pushType: nil
            )
            print("Live Activity iniciada: \(activity.id)")

            Task {
                try? await Task.sleep(nanoseconds: 10_000_000_000)
                await updateLiveActivity(state: .middle, activity: activity)
                
                try? await Task.sleep(nanoseconds: 5_000_000_000)
                await updateLiveActivity(state: .finished, activity: activity)
            }

        } catch {
            print("Erro ao iniciar Live Activity: \(error.localizedDescription)")
        }
    }
    
    func updateLiveActivity(state: LiveActivityPOCWidgetAttributes.ContentState, activity: Activity<LiveActivityPOCWidgetAttributes>) async {
        await activity.update(using: state)
    }

}

