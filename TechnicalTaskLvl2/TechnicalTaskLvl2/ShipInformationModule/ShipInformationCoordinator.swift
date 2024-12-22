import UIKit

final class ShipInformationCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    var presenterView: UIViewController?
    private weak var shipInfoViewController: ShipInformationViewController?
    
    var finish: (() -> Void)?
    
    init(presenterView: UIViewController? = nil) {
        self.presenterView = presenterView
        super.init()
        self.navigationController.presentationController?.delegate = self
    }
    
    func start() {
        let viewController = ShipInformationViewController()
        viewController.popToParent = { [weak self, weak viewController] in
            viewController?.dismiss(animated: true)
            self?.finish?()
        }
        shipInfoViewController = viewController
        navigationController.viewControllers = [viewController]
        presenterView?.present(navigationController, animated: true)
    }
}

extension ShipInformationCoordinator: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        finish?()
    }
}
