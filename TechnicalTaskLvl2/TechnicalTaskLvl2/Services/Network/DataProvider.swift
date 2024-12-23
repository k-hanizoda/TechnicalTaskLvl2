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
            throw NetworkError.requestFailed("Failed to fetch ships.")
        }
    }
}

private extension ShipsDataProvider {
    func fetchRequest<T: Decodable>(endpoint: APIEndpoint) async throws -> T {
        do {
            guard let data = try await networkService.get(urlRequest: endpoint) else {
                throw NetworkError.noData
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
            NetworkError.connectionFailed
        case is DecodingError:
            NetworkError.decodingFailed
        default:
            NetworkError.invalidServerResponse
        }
    }
}
