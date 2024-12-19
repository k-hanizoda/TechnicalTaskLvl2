import UIKit

final class LabeledInputField: UIView {
    private let label = UILabel()
    private let inputField: CustomTextField
    
    init(type: TextFieldType) {
        inputField = CustomTextField(type: type)
        super.init(frame: .zero)
        setupLabel(with: type.labelText)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(type:) instead to initialize LabeledInputField.")
    }
}

private extension LabeledInputField {
    func setupLabel(with text: String) {
        label.text = text
        label.textColor = .white.withAlphaComponent(0.8)
        TextStyle.applyDynamicType(to: label, font: TextStyle.description)
    }
    
    func setupLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        inputField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(inputField)
        NSLayoutConstraint.activate([
            inputField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8.0),
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputField.heightAnchor.constraint(equalToConstant: 50.0),
            
            bottomAnchor.constraint(equalTo: inputField.bottomAnchor)
        ])
    }
}
