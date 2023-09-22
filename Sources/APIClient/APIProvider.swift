import Foundation
import Domain

public class APIProvider {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    func getResponse<T: Decodable>(from endpoint: Endpoint, cache: Bool = true) async throws -> T {
        let request = URLRequestBuilder.parametersRequest.build(endpoint)
        return try await getResponse(from: request, cache: cache)
    }

    func getData(from request: URLRequest, cache: Bool = true) async throws -> Foundation.Data {
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
        if cache, let cachedResult: T = getCachedResponse(from: request) {
            return cachedResult
        }

        do {
            let (data, response) = try await session.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                switch httpResponse.statusCode {
                case 200...299:
                    return data
                case 401:
                    throw APIError.unauthorized
                default:
                    throw APIError.serverError(code: httpResponse.statusCode)
                }
            } else {
                throw APIError.invalidResponse
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
