import UIKit

final class ShipInformationViewController: UIViewController {
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
        imageView.image = .frigateShip
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 120.0
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameView = KeyValueView(type: .name)
    private let typeView = KeyValueView(type: .type)
    private let yearView = KeyValueView(type: .year)
    private let weightView = KeyValueView(type: .weight)
    private let homePortView = KeyValueView(type: .homePort)
    private let rolesView = KeyValueView(type: .roles)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameView, typeView, yearView, weightView, homePortView, rolesView])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkPurple
        setupNavigationBar()
        setupRightBarButton()
        setupLayout()
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
