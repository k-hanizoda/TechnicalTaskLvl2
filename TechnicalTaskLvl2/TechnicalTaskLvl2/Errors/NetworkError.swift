import Foundation

enum NetworkError: LocalizedError, Equatable {
    case invalidServerResponse
    case invalidURL
    case invalidStatusCode(Int)
    case noData
    case decodingFailed
    case connectionFailed
    case requestFailed(String)
    
    public var errorDescription: String {
        switch self {
        case .invalidServerResponse: "The server returned an invalid response."
        case .invalidURL: "The URL provided was invalid."
        case .invalidStatusCode(let statusCode): "The server returned an invalid status code: \(statusCode)."
        case .noData: "No data was received from the server."
        case .decodingFailed: "Failed to decode the response from the server."
        case .connectionFailed: "A network connection error occurred. Please check your internet connection."
        case .requestFailed(let reason): "The request failed with reason: \(reason)."
        }
    }
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidServerResponse, .invalidServerResponse):
            return true
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidStatusCode(let statusCode1), .invalidStatusCode(let statusCode2)):
            return statusCode1 == statusCode2
        case (.noData, .noData):
            return true
        case (.decodingFailed, .decodingFailed):
            return true
        case (.connectionFailed, .connectionFailed):
            return true
        case (.requestFailed(let reason1), .requestFailed(let reason2)):
            return reason1 == reason2
        default:
            return false
        }
    }
}
