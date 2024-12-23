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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        shipImage.image = nil
        nameLabel.text = nil
        typeLabel.text = nil
        yearLabel.text = nil
    }
    
    func configure(with shipItem: ShipItem) {
        shipImage.image = shipItem.image
        nameLabel.text = shipItem.name
        typeLabel.text = shipItem.type
        yearLabel.text = shipItem.year
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
}
