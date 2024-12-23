import Foundation

protocol NetworkService {
    func get(urlRequest: RequestRepresentable) async throws -> Data?
}

final class HTTPClient: NetworkService {
    func get(urlRequest: RequestRepresentable) async throws -> Data? {
        let urlRequest = try urlRequest.createURLRequest()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidServerResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
}
