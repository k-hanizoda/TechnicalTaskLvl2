import Foundation

enum APIEndpoint: RequestRepresentable {
    case fetchShips

    var host: String {
        APIConstants.host
    }

    var path: String {
        switch self {
        case .fetchShips: "ships"
        }
    }
    
    var requestType: RequestType {
        .GET
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = APIConstants.scheme
        components.host = host
        components.path = APIConstants.api + path
        
        return components.url
    }
}
