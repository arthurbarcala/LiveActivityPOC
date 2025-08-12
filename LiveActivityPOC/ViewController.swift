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
        Task {
            let dados = await fetchApiData()
            let widget = try JSONDecoder().decode(WidgetData.self, from: dados ?? Data())
            
            let attributes = LiveActivityPOCWidgetAttributes(name: widget.name)
            
            let initialState = LiveActivityPOCWidgetAttributes.ContentState(
                texts: widget.contentState.texts,
                seconds: Double(widget.contentState.seconds) ?? 0
            )
            
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
                return
            }
            
            Task {
                try? await Task.sleep(nanoseconds: ((UInt64(widget.contentState.seconds) ?? 0) + 1) * 1_000_000_000)
                await activity?.end(dismissalPolicy: .immediate)
            }
        }
        
        func updateLiveActivity(state: LiveActivityPOCWidgetAttributes.ContentState, activity: Activity<LiveActivityPOCWidgetAttributes>) async {
            await activity.update(using: state)
        }
        
        func fetchApiData() async -> Data? {
            let url = URL(string: "http://localhost:3000/attributes")
            guard let url = url else {
                print("URL inválida")
                return nil
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                return data
            } catch {
                print("Erro ao buscar dados da API: \(error.localizedDescription)")
                return nil
            }
        }
    }
}
