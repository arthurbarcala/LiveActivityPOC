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
        
        let apiButton = UIButton(type: .system)
        apiButton.setTitle("Fetch API", for: .normal)
        apiButton.addTarget(self, action: #selector(fetchAPI), for: .touchUpInside)
        apiButton.frame = CGRect(x: 0, y: 500, width: 200, height: 50)
        apiButton.center.x = view.center.x
        apiButton.backgroundColor = .systemGreen
        apiButton.setTitleColor(.white, for: .normal)
        view.addSubview(apiButton)
    }

    func startLiveActivity() {
        let attributes = LiveActivityPOCWidgetAttributes(name: "Widget")
        let initialState = LiveActivityPOCWidgetAttributes.ContentState.started

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
    
    @objc func restartLiveActivity() {
        guard let activity = activity else { return }
        Task {
            await activity.update(using: .started)
            
            try? await Task.sleep(nanoseconds: 10_000_000_000)
            await updateLiveActivity(state: .middle, activity: activity)
            
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            await updateLiveActivity(state: .finished, activity: activity)
        }
    }
    
    @objc func fetchAPI() {
        guard let activity = activity else { return }
        guard let url = URL(string: "https://api.adviceslip.com/advice") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Erro ao buscar dados da API: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let slip = json["slip"] as? [String: Any],
                  let advice = slip["advice"] as? String else {
                print("Erro ao analisar JSON")
                return
            }
            
            Task {
                let currentState = activity.contentState
                let newState = LiveActivityPOCWidgetAttributes.ContentState(emoji: currentState.emoji, progress: currentState.progress, advice: advice)
                await activity.update(using: newState)
            }
        }
        task.resume()
    }

}

