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
}

private extension ShipListViewModel {
    @MainActor
    func fetchData() async throws {
        do {
            let ships = try await dataProvider.fetchData()
            self.ships = ships
        } catch {
            throw NetworkError.requestFailed("Failed to fetch post items.")
        }
    }
}
