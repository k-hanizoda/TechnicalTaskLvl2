import UIKit

final class KeyValueView: UIView {
    private let keyLabel = UILabel()
    private let valueLabel = UILabel()
    
    private lazy var keyValueStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [keyLabel, valueLabel])
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        return stackView
    }()
    
    init(type: ShipDetailType, value: String = "") {
        super.init(frame: .zero)
        setupView()
        configure(with: type.labelText, value: value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(type:) instead to initialize KeyValueView.")
    }
}
    
private extension KeyValueView {
    func setupView() {
        setupAppearance()
        setupLayout()
    }
    
    func setupAppearance() {
        backgroundColor = .slateGray.withAlphaComponent(0.2)
        layer.masksToBounds = true
        layer.cornerRadius = 15.0
        
        keyLabel.textColor = .white.withAlphaComponent(0.8)
        TextStyle.applyDynamicType(to: keyLabel, font: TextStyle.header)
        
        valueLabel.textColor = .white
        TextStyle.applyDynamicType(to: valueLabel, font: TextStyle.body)
    }
    
    func configure(with keyText: String, value: String) {
        keyLabel.text = keyText
        valueLabel.text = value
    }
    
    func setupLayout() {
        let topInset: CGFloat = 10.0
        let leadingInset: CGFloat = 25.0
        let trailingInset: CGFloat = -5.0
        let bottomInset: CGFloat = -10.0
        
        keyValueStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(keyValueStackView)
        NSLayoutConstraint.activate([
            keyValueStackView.topAnchor.constraint(equalTo: topAnchor, constant: topInset),
            keyValueStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingInset),
            keyValueStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingInset),
            keyValueStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomInset)
        ])
    }
}
