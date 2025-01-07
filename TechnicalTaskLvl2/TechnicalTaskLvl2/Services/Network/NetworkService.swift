import Foundation

protocol NetworkService {
    func get(urlRequest: RequestRepresentable) async throws -> Data?
}

final class HTTPClient: NetworkService {
    func get(urlRequest: RequestRepresentable) async throws -> Data? {
        let urlRequest = try urlRequest.createURLRequest()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError(
                code: .invalidServerResponse,
                message: "The server returned an invalid response."
            )
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError(
                code: .invalidStatusCode(
                    httpResponse.statusCode
                ),
                message: "The server returned an invalid status code: \(httpResponse.statusCode)."
            )
        }
        
        return data
    }
}
