import UIKit

final class LoginCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    private weak var loginViewController: LoginViewController?
    
    var finish: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = LoginViewController(viewModel: LoginViewModel())
        viewController.navigateToShipList = { [weak self] mode in
            self?.navigateToShipList(with: mode)
        }
        loginViewController = viewController
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToShipList(with mode: UserMode) {
        let coordinator = ShipListCoordinator(
            dataProvider: ShipsDataProvider(),
            presenterView: loginViewController,
            navigationController: navigationController,
            userMode: mode
        )
        coordinator.finish = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.removeChild(coordinator)
            }
        }
        coordinator.start()
        addChild(coordinator)
    }
}
