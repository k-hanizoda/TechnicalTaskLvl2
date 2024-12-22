import UIKit

final class LabeledInputField: UIView {
    enum Constants {
        static let emptyString = ""
    }
    
    var onTextChanged: ((String) -> Void)?
    
    private let label = UILabel()
    private let inputField: CustomTextField
    private let invalidEmailLabel = UILabel()
    
    init(type: TextFieldType) {
        inputField = CustomTextField(type: type)
        super.init(frame: .zero)
        setupLabel(with: type.labelText)
        setupInvalidEmailLabel()
        setupLayout()
        
        inputField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        if type == .email {
            inputField.addTarget(self, action: #selector(validateEmail), for: .editingChanged)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(type:) instead to initialize LabeledInputField.")
    }
    
    func clearInput() {
        inputField.text = Constants.emptyString
        onTextChanged?(Constants.emptyString)
    }
}

private extension LabeledInputField {
    func setupLabel(with text: String) {
        label.text = text
        label.textColor = .white.withAlphaComponent(0.8)
        TextStyle.applyDynamicType(to: label, font: TextStyle.description)
    }
    
    func setupInvalidEmailLabel() {
        invalidEmailLabel.text = Localizable.invalidEmailLabel
        invalidEmailLabel.textColor = .candyAppleRed
        TextStyle.applyDynamicType(to: invalidEmailLabel, font: TextStyle.title)
        invalidEmailLabel.numberOfLines = 0
        invalidEmailLabel.textAlignment = .left
        invalidEmailLabel.isHidden = true
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
        
        invalidEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(invalidEmailLabel)
        NSLayoutConstraint.activate([
            invalidEmailLabel.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 8.0),
            invalidEmailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15.0),
            invalidEmailLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    @objc func textFieldDidChange() {
        onTextChanged?(inputField.text ?? Constants.emptyString)
    }
    
    @objc func validateEmail() {
        if let email = inputField.text, !email.isValidEmail() {
            invalidEmailLabel.isHidden = false
            inputField.layer.borderWidth = 2.0
            inputField.layer.borderColor = UIColor.candyAppleRed.cgColor
        } else {
            invalidEmailLabel.isHidden = true
            inputField.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
