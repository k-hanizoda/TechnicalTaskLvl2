import UIKit

struct ShipItem{
    let image: UIImage
    let name: String
    let type: String
    let year: String
}

final class ShipListViewModel {
    @Published private(set) var postItems: [ShipItem] = [ShipItem(
        image: UIImage(named: "Battleship")!,
        name: "Aurora",
        type: "Battleship",
        year: "2023"
    ), ShipItem(
        image: UIImage(named: "Frigate")!,
        name: "Tempest",
        type: "Frigate",
        year: "2002"
    ), ShipItem(
        image: UIImage(named: "Battleship")!,
        name: "Oblivion",
        type: "Dreadnought",
        year: "2016"
    )]
    
    func numberOfRowsInSection(section: Int) -> Int {
        postItems.count
    }
}
