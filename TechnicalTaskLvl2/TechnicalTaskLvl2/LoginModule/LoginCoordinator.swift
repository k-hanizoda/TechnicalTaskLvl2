import UIKit

final class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    var finish: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = LoginViewController(viewModel: LoginViewModel())
        viewController.navigateToShipList = { [weak self] mode in
            self?.navigateToShipList(with: mode)
        }
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToShipList(with mode: UserMode) {
        let coordinator = ShipListCoordinator(navigationController: navigationController, userMode: mode)
        coordinator.finish = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.removeChild(coordinator)
            }
        }
        coordinator.start()
        addChild(coordinator)
    }
}
