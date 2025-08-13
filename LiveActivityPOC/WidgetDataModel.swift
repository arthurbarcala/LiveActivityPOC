struct ContentState: Codable {
    let texts: [String:String]
    let widgetDuration: String
    let refreshDelay: String?
}

struct WidgetData: Codable {
    let name: String
    let contentState: ContentState
}
