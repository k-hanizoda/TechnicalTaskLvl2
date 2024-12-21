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
        viewController.login = { [weak self] in
            self?.navigateToShipList()
        }
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToShipList() {
        let coordinator = ShipListCoordinator(navigationController: navigationController)
        coordinator.finish = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.removeChild(coordinator)
            }
        }
        coordinator.start()
        addChild(coordinator)
    }
}
