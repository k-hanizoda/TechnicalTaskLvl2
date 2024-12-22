import UIKit

final class ShipInformationViewController: UIViewController {
    var popToParent: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkPurple
        setupNavigationBar()
        setupRightBarButton()
    }
    
    func setupNavigationBar() {
        navigationItem.title = Localizable.shipListTitle
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .darkPurple.withAlphaComponent(0.9)
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.flashWhite]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = .darkPurple
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.flashWhite]
        
        navigationController?.navigationBar.standardAppearance = standardAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = scrollEdgeAppearance
        
        navigationItem.hidesBackButton = true
    }
     
    func setupRightBarButton() {
        let rightButtonTitle = "Back"
        let rightBarButton = UIBarButtonItem(
            title: rightButtonTitle,
            style: .plain,
            target: self,
            action: #selector(exitAction)
        )
        rightBarButton.tintColor = .flashWhite
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func exitAction() {
        popToParent?()
    }
}
