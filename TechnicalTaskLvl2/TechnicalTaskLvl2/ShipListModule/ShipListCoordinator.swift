import UIKit

final class ShipListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presenterView: UIViewController?
    private let dataProvider: DataProvider
    private let userMode: UserMode
    private weak var shipListViewController: ShipListViewController?
    
    var finish: (() -> Void)?
    
    init(
        dataProvider: DataProvider,
        presenterView: UIViewController? = nil,
        navigationController: UINavigationController,
        userMode: UserMode
    ) {
        self.dataProvider = dataProvider
        self.presenterView = presenterView
        self.navigationController = navigationController
        self.userMode = userMode
    }
    
    func start() {
        let shipListViewModel = ShipListViewModel(dataProvider: dataProvider)
        let viewController = ShipListViewController(viewModel: shipListViewModel, userMode: userMode)
        viewController.back = { [weak self] in
            self?.navigationController.popToRootViewController(animated: true)
            self?.finish?()
        }
        viewController.navigateToShipInfo = { [weak self] ship in
            self?.navigateToShipInfo(ship: ship)
        }
        shipListViewController = viewController
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func navigateToShipInfo(ship: Ship) {
        let coordinator = ShipInfoCoordinator(presenterView: shipListViewController, ship: ship)
        coordinator.finish = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.removeChild(coordinator)
            }
        }
        coordinator.start()
        addChild(coordinator)
    }
}
