import Foundation
import Combine

final class ShipInfoViewModel {
    @Published private(set) var ship: Ship
    
    init(ship: Ship) {
        self.ship = ship
    }
}
