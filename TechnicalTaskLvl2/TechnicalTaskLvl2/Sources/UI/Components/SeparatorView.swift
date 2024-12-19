import UIKit

final class SeparatorView: UIView {
    private let leftLineView = UIView()
    private let rightLineView = UIView()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.orLabel
        label.textColor = .white.withAlphaComponent(0.6)
        TextStyle.applyDynamicType(to: label, font: TextStyle.body)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftLineView, orLabel, rightLineView])
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLineView(leftLineView)
        configureLineView(rightLineView)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
}

private extension SeparatorView {
     func configureLineView(_ lineView: UIView) {
        lineView.backgroundColor = .white.withAlphaComponent(0.6)
    }
    
    func setupLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rightLineView.heightAnchor.constraint(equalToConstant: 1.0),
            rightLineView.widthAnchor.constraint(equalToConstant: 140.0),
            
            leftLineView.heightAnchor.constraint(equalToConstant: 1.0),
            leftLineView.widthAnchor.constraint(equalToConstant: 140.0),
            leftLineView.widthAnchor.constraint(equalTo: rightLineView.widthAnchor)
        ])
    }
}
