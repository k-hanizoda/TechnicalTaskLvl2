import Foundation

enum ImageLoadingError: LocalizedError {
    case failedToCreateImage
    
    public var errorDescription: String? {
        switch self {
        case .failedToCreateImage:
            return NSLocalizedString("Unable to create image from the provided URL.", comment: "Error when image creation fails")
        }
    }
}
