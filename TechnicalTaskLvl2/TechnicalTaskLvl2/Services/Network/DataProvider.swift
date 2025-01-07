import Foundation

protocol DataProvider {
    func fetchData() async throws -> [Ship]
}

final class ShipsDataProvider: DataProvider {
    private let networkService: NetworkService
    private let decoder: JSONService
    
    init(
        networkService: NetworkService = HTTPClient(),
        decoder: JSONService = JSONService()
    ){
        self.networkService = networkService
        self.decoder = decoder
    }

    func fetchData() async throws -> [Ship] {
        do {
            return try await fetchRequest(endpoint: APIEndpoint.fetchShips) as [Ship]
        } catch {
            throw NetworkError(
                code: .requestFailed,
                message: "Failed to fetch ships.",
                underlyingError: error
            )
        }
    }
}

private extension ShipsDataProvider {
    func fetchRequest<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        do {
            guard let data = try await networkService.get(urlRequest: endpoint) else {
                throw NetworkError(
                    code: .noData,
                    message: "No data was received from the server."
                )
            }
            
            return try decoder.decode(data: data)
        } catch {
            try handleNetworkErrors(error)
            throw error
        }
    }
    
    func handleNetworkErrors(_ error: Error) throws {
        throw switch error {
        case is URLError:
            NetworkError(
                code: .connectionFailed,
                message: "A network connection error occurred. Please check your internet connection.",
                underlyingError: error
            )
        case is DecodingError:
            NetworkError(
                code: .decodingFailed,
                message: "Failed to decode the response from the server.",
                underlyingError: error
            )
        default:
            NetworkError(
                code: .invalidServerResponse,
                message: "The server returned an invalid response.",
                underlyingError: error
            )
        }
    }
}
