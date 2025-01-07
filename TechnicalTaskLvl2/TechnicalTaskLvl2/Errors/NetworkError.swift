import Foundation

struct NetworkError: LocalizedError {
    let code: Code
    let message: String
    let underlyingError: Error?
    
    enum Code {
        case invalidServerResponse
        case invalidURL
        case invalidStatusCode(Int)
        case noData
        case decodingFailed
        case connectionFailed
        case requestFailed
    }
    
    init(code: Code, message: String, underlyingError: Error? = nil) {
        self.code = code
        self.message = message
        self.underlyingError = underlyingError
    }
}
