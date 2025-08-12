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
        button.addTarget(self, action: #selector(restartLiveActivity), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }

    func startLiveActivity() {
        let attributes = LiveActivityPOCWidgetAttributes(name: "Widget")
        var seconds = 14400
        let initialState = LiveActivityPOCWidgetAttributes.ContentState.seguroContratado
        
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

            //Fiz dessa forma sem utilizar websockets, porém acredito que não seja muito viável
            Task {
                while (seconds > 0) {
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    await activity.update(using: LiveActivityPOCWidgetAttributes.ContentState(progress: 0, seconds: seconds))
                    seconds -= 1
                }
            }

        } catch {
            print("Erro ao iniciar Live Activity: \(error.localizedDescription)")
        }
    }
    
    func updateLiveActivity(state: LiveActivityPOCWidgetAttributes.ContentState, activity: Activity<LiveActivityPOCWidgetAttributes>) async {
        await activity.update(using: state)
    }
    
    @objc func restartLiveActivity() {
        guard let activity = activity else { return }
        Task {
            await activity.update(using: .seguroContratado)
            
            try? await Task.sleep(nanoseconds: 10_000_000_000)
            await updateLiveActivity(state: .apoliceEmitida, activity: activity)
            
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            await updateLiveActivity(state: .cashbackLiberado, activity: activity)
        }
    }

}

