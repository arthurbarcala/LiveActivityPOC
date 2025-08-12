struct ContentState: Codable {
    let texts: [String]
    let seconds: String
}

struct WidgetData: Codable {
    let name: String
    let contentState: ContentState
}
