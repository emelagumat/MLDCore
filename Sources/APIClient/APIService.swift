public protocol APIService<Action> {
    associatedtype Action: APIServiceAction

    var baseStringURL: String { get }
    var path: String { get }

    func buildEndpoint(with action: Action) -> Endpoint
}

public extension APIService {
    func buildEndpoint(with action: Action) -> Endpoint {
        Endpoint(
            baseStringURL: baseStringURL,
            path: path + action.subpath,
            parameters: action.parameters,
            method: action.method,
            task: action.task
        )
    }
}
