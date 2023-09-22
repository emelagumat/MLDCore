public protocol APIServiceAction {
    var subpath: String { get }
    var parameters: [String: Any] { get }
    var method: HTTPMethod { get }
    var task: HTTPTask { get }
}

// MARK: - Default values
public extension APIServiceAction {
    var method: HTTPMethod { .get }
    var task: HTTPTask { .queryParams }
}
