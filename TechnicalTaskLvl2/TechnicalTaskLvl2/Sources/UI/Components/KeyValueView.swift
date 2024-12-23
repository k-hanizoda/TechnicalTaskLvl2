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
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(type:) instead to initialize KeyValueView.")
    }
    
    func configure(type: ShipDetailType, valueText: String) {
        valueLabel.text = valueText
        keyLabel.text = type.labelText
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
        TextStyle.applyDynamicType(to: keyLabel, font: TextStyle.body)
        
        valueLabel.textColor = .flashWhite
        TextStyle.applyDynamicType(to: valueLabel, font: TextStyle.header)
    }
    
    func setupLayout() {
        let topInset: CGFloat = 10.0
        let leadingInset: CGFloat = 25.0
        let trailingInset: CGFloat = -15.0
        let bottomInset: CGFloat = -10.0
        
        keyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        valueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
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
