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
            self?.finish?()
        }
        navigationController.pushViewController(viewController, animated: false)
    }
}
