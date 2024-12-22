import UIKit

final class ShipListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    private let userMode: UserMode
    
    var finish: (() -> Void)?
    
    init(navigationController: UINavigationController, userMode: UserMode) {
        self.navigationController = navigationController
        self.userMode = userMode
    }
    
    func start() {
        let viewController = ShipListViewController(viewModel: ShipListViewModel(), userMode: userMode)
        viewController.back = { [weak self] in
            self?.navigationController.popToRootViewController(animated: true)
            self?.finish?()
        }
        navigationController.pushViewController(viewController, animated: false)
    }
}
