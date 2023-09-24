
import Foundation

public struct Endpoint {
    public let baseStringURL: String
    public let path: String
    public let parameters: [String: Any]
    public let method: HTTPMethod
    public let task: HTTPTask
    public let headers: [String: String]
    
    public init(
        baseStringURL: String,
        path: String,
        parameters: [String : Any],
        method: HTTPMethod,
        task: HTTPTask,
        headers: [String : String] = [:]
    ) {
        self.baseStringURL = baseStringURL
        self.path = path
        self.parameters = parameters
        self.method = method
        self.task = task
        self.headers = headers
    }
}

extension Endpoint {
    var fullStringURL: String {
        baseStringURL + path
    }
}

struct URLRequestBuilder<Z> {
    let build: (Z) -> URLRequest
}

extension URLRequestBuilder where Z == Endpoint {
    static var parametersRequest: URLRequestBuilder {
        .init { endpoint in
            guard
                let url = URL(string: endpoint.fullStringURL)
            else {
                assertionFailure("Invalid URL")
                return URLRequest(url: URL(filePath: "/"))
            }

            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.allHTTPHeaderFields = endpoint.headers
            switch endpoint.task {
            case .queryParams:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                if !endpoint.parameters.isEmpty {
                    components?.queryItems = endpoint.parameters.map(URLQueryItem.init)
                }
                request.url = components?.url
            case .httpBody:
                if let data = try? JSONSerialization.data(
                    withJSONObject: endpoint.parameters,
                    options: .prettyPrinted
                ) {
                    request.httpBody = data
                }
            }

            return request
        }

    }
}

private extension URLQueryItem {
    init(key: String, value: Any) {
        self.init(name: key, value: "\(value)")
    }
}
