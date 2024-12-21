import UIKit

final class ShipListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    var finish: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ShipListViewController()
        viewController.back = { [weak self] in
            self?.navigationController.popToRootViewController(animated: true)
            self?.finish?()
        }
        navigationController.pushViewController(viewController, animated: false)
    }
}
