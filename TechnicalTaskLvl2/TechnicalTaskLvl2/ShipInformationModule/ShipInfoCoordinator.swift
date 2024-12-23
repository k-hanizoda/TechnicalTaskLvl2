import UIKit

final class ShipInfoCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presenterView: UIViewController?
    var ship: Ship?
    private weak var shipInfoViewController: ShipInfoViewController?
    
    var finish: (() -> Void)?
    
    init(presenterView: UIViewController? = nil, ship: Ship?) {
        self.presenterView = presenterView
        self.ship = ship
        super.init()
        self.navigationController.presentationController?.delegate = self
    }
    
    func start() {
        guard let ship else { return }
        let shipInfoViewModel = ShipInfoViewModel(ship: ship)
        let viewController = ShipInfoViewController(viewModel: shipInfoViewModel)
        viewController.popToParent = { [weak self, weak viewController] in
            viewController?.dismiss(animated: true)
            self?.finish?()
        }
        shipInfoViewController = viewController
        navigationController.viewControllers = [viewController]
        presenterView?.present(navigationController, animated: true)
    }
}

extension ShipInfoCoordinator: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        finish?()
    }
}
