import Foundation

open class APIProvider {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    open func buildRequest(from endpoint: Endpoint) -> URLRequest {
        URLRequestBuilder.parametersRequest.build(endpoint)
    }

    open func getResponse<T: Decodable>(from endpoint: Endpoint, cache: Bool = true) async throws -> T {
        let request = buildRequest(from: endpoint)
        return try await getResponse(from: request, cache: cache)
    }

    open func getData(from request: URLRequest, cache: Bool = true) async throws -> Foundation.Data {
        if cache, let cachedData = getCachedData(from: request) {
            return cachedData
        }
        do {
            let (data, response) = try await session.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                switch httpResponse.statusCode {
                case 401:
                    throw APIError.unauthorized
                default:
                    throw APIError.serverError(code: httpResponse.statusCode)
                }
            }
            return data
        } catch {
            throw APIError.unknown
        }
    }
}

// MARK: - Helpers
extension APIProvider {
    func getResponse<T: Decodable>(from request: URLRequest, cache: Bool = true) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            let httpResponse = response as? HTTPURLResponse
            if let httpResponse, !(200...299).contains(httpResponse.statusCode) {
                switch httpResponse.statusCode {
                case 401:
                    throw APIError.unauthorized
                default:
                    throw APIError.serverError(code: httpResponse.statusCode)
                }
            } else {
                return try JSONDecoder().decode(T.self, from: data)
            }
        } catch {
            throw APIError.unknown
        }
    }

    private func getCachedResponse <T: Decodable>(from request: URLRequest) -> T? {
        guard
            let data = getCachedData(from: request),
            let apiResponse = try? JSONDecoder().decode(T.self, from: data)
        else { return nil }

        return apiResponse
    }

    private func getCachedData(from request: URLRequest) -> Foundation.Data? {
        guard
            let data = session.configuration.urlCache?.cachedResponse(for: request)?.data
        else { return nil }

        return data
    }
}
