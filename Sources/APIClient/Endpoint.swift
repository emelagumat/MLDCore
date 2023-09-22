public struct Endpoint {
    let baseStringURL: String
    let path: String
    let parameters: [String: Any]
    let method: HTTPMethod
    let task: HTTPTask
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

            switch endpoint.task {
            case .queryParams:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                if !endpoint.parameters.isEmpty {
                    components?.queryItems = endpoint.parameters.map(URLQueryItem.init)
                }
                request.url = components?.url
            case .httpBody:
                let data = JSONSerialization.data(
                    withJSONObject: endpoint.parameters,
                    options: .prettyPrinted
                )
                request.httpBody = data
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
