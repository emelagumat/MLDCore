public enum APIError: Error {
    case invalidRequest
    case invalidResponse
    case parsingError
    case unauthorized
    case serverError(code: Int)
    case unknown
}
