import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        window?.rootViewController = navigationController
        navigateToLogin()
    }
    
    private func navigateToLogin() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        coordinator.finish = { [weak self, weak coordinator] in
            if let coordinator = coordinator {
                self?.removeChild(coordinator)
            }
            self?.navigationController.viewControllers.removeAll()
        }
        coordinator.start()
        addChild(coordinator)
    }
}
