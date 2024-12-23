import UIKit

final class ShipListViewModel {
    @Published private(set) var ships: [Ship] = []
    private var dataProvider: DataProvider
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        
        Task { [weak self] in
            try await self?.fetchData()
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        ships.count
    }
    
    @MainActor
    func fetchData() async throws {
        do {
            let ships = try await dataProvider.fetchData()
            self.ships = ships.sorted {
                $0.name.lowercased() < $1.name.lowercased()
            }
        } catch {
            throw NetworkError.requestFailed("Failed to fetch post items.")
        }
    }
}
