import UIKit

final class ShipListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presenterView: UIViewController?
    private let userMode: UserMode
    private weak var shipListViewController: ShipListViewController?
    
    var finish: (() -> Void)?
    
    init(presenterView: UIViewController? = nil, navigationController: UINavigationController, userMode: UserMode) {
        self.presenterView = presenterView
        self.navigationController = navigationController
        self.userMode = userMode
    }
    
    func start() {
        let viewController = ShipListViewController(viewModel: ShipListViewModel(), userMode: userMode)
        viewController.back = { [weak self] in
            self?.navigationController.popToRootViewController(animated: true)
            self?.finish?()
        }
        viewController.navigateToShipInfo = { [weak self] index in
            self?.navigateToShipInfo(selectedIndex: index)
        }
        shipListViewController = viewController
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func navigateToShipInfo(selectedIndex: Int) {
        let coordinator = ShipInformationCoordinator(presenterView: shipListViewController)
        coordinator.finish = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.removeChild(coordinator)
            }
        }
        coordinator.start()
        addChild(coordinator)
    }
}
