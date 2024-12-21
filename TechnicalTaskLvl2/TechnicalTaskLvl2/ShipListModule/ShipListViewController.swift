import UIKit

final class ShipListViewController: UIViewController {
    var back: (() -> Void)?
    private let userMode: UserMode
    
    init(userMode: UserMode) {
        self.userMode = userMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented. Use the custom initializer to instantiate this view controller programmatically.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
    
private extension ShipListViewController {
    func setupUI() {
        view.backgroundColor = .darkPurple
        navigationItem.title = "Ship List"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.flashWhite
        ]
        navigationItem.hidesBackButton = true
        
        let rightButtonTitle: String
        
        switch userMode {
        case .user:
            rightButtonTitle = "LogOut"
        case .guest:
            rightButtonTitle = "Exit"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: rightButtonTitle,
            style: .plain,
            target: self,
            action: #selector(exitAction)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = .flashWhite
    }
    
    @objc func exitAction() {
        back?()
    }
}
