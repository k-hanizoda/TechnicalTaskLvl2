import UIKit
import Combine

final class ShipInfoViewController: UIViewController {
    private var viewModel: ShipInfoViewModel
    private var cancellable = Set<AnyCancellable>()
    
    var popToParent: (() -> Void)?
    
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let shipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 120.0
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameView = KeyValueView()
    private let typeView = KeyValueView()
    private let yearView = KeyValueView()
    private let weightView = KeyValueView()
    private let homePortView = KeyValueView()
    private let rolesView = KeyValueView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameView, typeView, yearView, weightView, homePortView, rolesView])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    init(viewModel: ShipInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented. Use the custom initializer to instantiate this view controller programmatically.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkPurple
        setupNavigationBar()
        setupRightBarButton()
        setupLayout()
        bind()
    }
}

private extension ShipInfoViewController {
    func bind() {
        viewModel.$ship
            .receive(on: DispatchQueue.main)
            .sink { [weak self] ship in
                self?.configureKeyValueViews(with: ship)
                self?.loadShipImage(from: ship.image)
            }
            .store(in: &cancellable)
    }
        
    func configureKeyValueViews(with ship: Ship) {
        nameView.configure(type: .name, valueText: ship.name)
        typeView.configure(type: .type, valueText: ship.type)
        yearView.configure(type: .year, valueText: ship.builtYear.toString(defaultValue: Localizable.notAssigned))
        weightView.configure(type: .weight, valueText: ship.weight.toString(defaultValue: Localizable.notAssigned))
        homePortView.configure(type: .homePort, valueText: ship.homePort ?? Localizable.notAssigned)
        rolesView.configure(type: .roles, valueText: ship.roles?.joined(separator: ", ") ?? Localizable.notAssigned)
    }
        
    func loadShipImage(from url: URL?) {
        guard let url else {
            shipImageView.image = .frigateShip
            return
        }
        
        Task {
            await shipImageView.loadFromURL(url)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.title = Localizable.shipInfoTitle
        navigationItem.hidesBackButton = true
    }
     
    func setupRightBarButton() {
        let systemImageName = "xmark"
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: systemImageName),
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
    
    func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        shipImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shipImageView)
        NSLayoutConstraint.activate([
            shipImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            shipImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40.0),
            shipImageView.widthAnchor.constraint(equalToConstant: 240.0),
            shipImageView.heightAnchor.constraint(equalToConstant: 240.0)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: shipImageView.bottomAnchor, constant: 30.0),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0)
        ])
    }
}
