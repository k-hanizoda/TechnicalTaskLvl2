import Foundation

enum RequestType: String {
    case GET
}

protocol RequestRepresentable {
    var api: String { get }
    var host: String { get }
    var path: String { get }
    var requestType: RequestType { get }
    var url: URL? { get }
}

// MARK: - Default RequestRepresentable
extension RequestRepresentable {
    var api: String {
        APIConstants.api
    }
    
    var addAuthorizationToken: Bool {
        true
    }
    
    func createURLRequest() throws -> URLRequest {
        guard let url else { throw NetworkError.invalidURL }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        return urlRequest
    }
}
