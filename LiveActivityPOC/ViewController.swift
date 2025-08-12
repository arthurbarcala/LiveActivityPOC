import UIKit
import ActivityKit

class ViewController: UIViewController {
    
    var activity: Activity<LiveActivityPOCWidgetAttributes>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 16.1, *) {
            startLiveActivity()
        }

        let button = UIButton(type: .system)
        button.setTitle("Start Live Activity", for: .normal)
        button.addTarget(self, action: #selector(startLiveActivity), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }

    @objc func startLiveActivity() {
        let attributes = LiveActivityPOCWidgetAttributes(name: "Widget")
        let initialState = LiveActivityPOCWidgetAttributes.ContentState.seguroContratado
        let seconds = initialState.seconds
        
        do {
            activity = try Activity<LiveActivityPOCWidgetAttributes>.request(
                attributes: attributes,
                contentState: initialState,
                pushType: nil
            )
            
            guard let activity = activity else {
                print("Erro ao iniciar Live Activity: activity é nil")
                return
            }
            
            print("Live Activity iniciada: \(activity.id)")
            
            Task {
                try? await Task.sleep(nanoseconds: UInt64(seconds + 1) * 1_000_000_000)
                await activity.end(dismissalPolicy: .immediate)
            }

        } catch {
            print("Erro ao iniciar Live Activity: \(error.localizedDescription)")
        }
    }
    
    func updateLiveActivity(state: LiveActivityPOCWidgetAttributes.ContentState, activity: Activity<LiveActivityPOCWidgetAttributes>) async {
        await activity.update(using: state)
    }
}

