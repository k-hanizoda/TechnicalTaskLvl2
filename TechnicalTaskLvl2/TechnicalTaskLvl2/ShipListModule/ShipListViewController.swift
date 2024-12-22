import UIKit

final class ShipListViewController: UIViewController {
    private var viewModel: ShipListViewModel
    
    var back: (() -> Void)?
    var navigateToShipInfo: ((Int) -> Void)?
    private let userMode: UserMode
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ShipTableViewCell.self, forCellReuseIdentifier: ShipTableViewCell.identifier)
        tableView.separatorColor = .slateGray
        return tableView
    }()
    
    init(viewModel: ShipListViewModel ,userMode: UserMode) {
        self.viewModel = viewModel
        self.userMode = userMode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented. Use the custom initializer to instantiate this view controller programmatically.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkPurple
        setupNavigationBar()
        setupRightBarButton()
        setupLayout()
    }
}
    
private extension ShipListViewController {
    func setupNavigationBar() {
        navigationItem.title = Localizable.shipListTitle
        navigationItem.hidesBackButton = true
    }
     
    func setupRightBarButton() {
        let rightButtonTitle = getRightButtonTitle(for: userMode)
        let rightBarButton = UIBarButtonItem(
            title: rightButtonTitle,
            style: .plain,
            target: self,
            action: #selector(exitAction)
        )
        rightBarButton.tintColor = .flashWhite
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func getRightButtonTitle(for mode: UserMode) -> String {
        switch mode {
        case .user:
            return Localizable.logOutTitle
        case .guest:
            return Localizable.exitTitle
        }
    }
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func exitAction() {
        if userMode == .guest {
            showAlert(title: nil, message: Localizable.alertGuestModelTitle) { [weak self] in
                self?.back?()
            }
        } else {
            back?()
        }
    }
}

extension ShipListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShipTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModel.postItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToShipInfo?(indexPath.row)
    }
}
