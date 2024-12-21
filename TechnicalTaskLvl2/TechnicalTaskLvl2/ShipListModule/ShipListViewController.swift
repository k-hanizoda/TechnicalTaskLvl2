import UIKit

final class ShipListViewController: UIViewController {
    var back: (() -> Void)?
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .candyAppleRed
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        
        button.addTarget(self, action: #selector(exitAction), for: .touchUpInside)
    }
    
    @objc private func exitAction() {
        back?()
    }
}
