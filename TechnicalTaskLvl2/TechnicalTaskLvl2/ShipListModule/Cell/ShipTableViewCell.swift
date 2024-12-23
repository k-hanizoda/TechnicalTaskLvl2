import UIKit

final class ShipTableViewCell: UITableViewCell {
    private let shipImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 50.0
        return imageView
    }()

    private var nameLabel = ShipTableViewCell.makeLabel(withFontStyle: TextStyle.header)
    private var typeLabel = ShipTableViewCell.makeLabel(withFontStyle: TextStyle.body)
    private var yearLabel = ShipTableViewCell.makeLabel(withFontStyle: TextStyle.description)

    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel, yearLabel])
        stackView.axis = .vertical
        stackView.spacing = 10.0
        return stackView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white.withAlphaComponent(0.8)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupSelectedBackground()
        setupActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupActivityIndicator()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shipImage.image = nil
        nameLabel.text = nil
        typeLabel.text = nil
        yearLabel.text = nil
    }
    
    func configure(with ship: Ship) {
        nameLabel.text = ship.name
        typeLabel.text = ship.type
        yearLabel.text = ship.builtYear != nil ? String(ship.builtYear!) : Localizable.notAssigned
        
        guard let imageUrl = ship.image else {
            shipImage.image = .frigateShip
            return
        }
        
        activityIndicator.startAnimating()
        Task {
            await shipImage.loadFromURL(imageUrl)
            self.activityIndicator.stopAnimating()
        }
    }

    static func makeLabel(withFontStyle fontStyle: UIFont) -> UILabel {
        let label = UILabel()
        label.textColor = .flashWhite
        label.numberOfLines = 0
        label.textAlignment = .left
        TextStyle.applyDynamicType(to: label, font: fontStyle)
        return label
    }
}

private extension ShipTableViewCell {
    private func setupSelectedBackground() {
        let selectedBackground = UIView()
        selectedBackground.backgroundColor = .slateGray.withAlphaComponent(0.2)
        self.selectedBackgroundView = selectedBackground
    }
    
    func setupUI() {
        backgroundColor = .darkPurple
        
        let topInset: CGFloat = 10.0
        let leadingInset: CGFloat = 25.0
        let trailingInset: CGFloat = -5.0
        let bottomInset: CGFloat = -10.0
        let shipSide: CGFloat = 100.0
        
        shipImage.translatesAutoresizingMaskIntoConstraints = false
        addSubview(shipImage)
        NSLayoutConstraint.activate([
            shipImage.topAnchor.constraint(equalTo: topAnchor, constant: topInset),
            shipImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingInset),
            shipImage.widthAnchor.constraint(equalToConstant: shipSide),
            shipImage.heightAnchor.constraint(equalToConstant: shipSide)
        ])
        
        userInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userInfoStackView)
        NSLayoutConstraint.activate([
            userInfoStackView.topAnchor.constraint(equalTo: topAnchor, constant: topInset),
            userInfoStackView.leadingAnchor.constraint(equalTo: shipImage.trailingAnchor, constant: leadingInset),
            userInfoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingInset),
            userInfoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomInset)
        ])
    }
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: shipImage.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: shipImage.centerYAnchor)
        ])
    }
}
