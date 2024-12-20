import UIKit

final class CustomTextField: UITextField {
    private let toggleButton = UIButton(type: .system)
    private let leftImageView = UIImageView()
    private let padding: CGFloat = 16.0
    
    private var isPasswordVisible = false
    private var hasVisibilityToggle: Bool = false
    
    init(type: TextFieldType) {
        super.init(frame: .zero)
        self.delegate = self
        self.isSecureTextEntry = type.isSecure
        self.hasVisibilityToggle = type.showVisibilityToggle
        configureTextField(placeholder: type.placeholder)
        setupLeftView(with: type.systemImageName)
        if type.showVisibilityToggle {
            setupRightView()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension CustomTextField {
    func configureTextField(placeholder: String) {
        backgroundColor = .coolGrey
        layer.cornerRadius = 25.0
        clipsToBounds = true
        textColor = .white
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        autocapitalizationType = .none
        
        self.placeholder = placeholder
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.7)]
        )
    }
    
    func setupLeftView(with systemImageName: String) {
        let visibilityPadding = padding + 20.0
        
        leftImageView.image = UIImage(systemName: systemImageName)
        leftImageView.tintColor = .white.withAlphaComponent(0.7)
        leftImageView.layer.masksToBounds = true
        leftImageView.contentMode = .scaleAspectFit
        
        leftView = createPaddingView(with: leftImageView, padding: visibilityPadding)
        leftViewMode = .always
    }
    
    func setupRightView() {
        let visibilityPadding = padding + 40.0
        
        toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
        toggleButton.tintColor = .white.withAlphaComponent(0.7)
        toggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        rightView = createPaddingView(with: toggleButton, padding: visibilityPadding)
        rightViewMode = .always
    }
    
    func createPaddingView(with subview: UIView, padding: CGFloat) -> UIView {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: 50.0))
        subview.frame = CGRect(x: self.padding, y: 0, width: 25.0, height: 20.0)
        subview.center.y = paddingView.center.y
        paddingView.addSubview(subview)
        return paddingView
    }
    
    @objc func togglePasswordVisibility() {
        isPasswordVisible.toggle()
        isSecureTextEntry = !isPasswordVisible
        
        let imageName = isPasswordVisible ? "eye.slash" : "eye"
        toggleButton.setImage(UIImage(systemName: imageName), for: .normal)
        
        if let existingText = text {
            text = ""
            insertText(existingText)
        }
    }
}

extension CustomTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let visibilityPadding: CGFloat = 50.0
        
        let rightInset = hasVisibilityToggle ? visibilityPadding : padding
        return bounds.inset(by: UIEdgeInsets(top: 0, left: visibilityPadding, bottom: 0, right: rightInset))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
