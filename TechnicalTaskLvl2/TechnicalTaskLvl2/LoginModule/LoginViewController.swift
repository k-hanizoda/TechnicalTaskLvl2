import UIKit

final class LoginViewController: UIViewController {
    private var enteredEmail: String = ""
    private var enteredPassword: String = ""
    
    private let contentView = UIView()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .onDrag
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let boatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sailboat.fill")
        imageView.tintColor = .white.withAlphaComponent(0.7)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.welcomeLabel
        label.textColor = .white.withAlphaComponent(0.8)
        TextStyle.applyDynamicType(to: label, font: TextStyle.header)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let emailInput = LabeledInputField(type: .email)
    private let passwordInput = LabeledInputField(type: .password)
    private let separatorView = SeparatorView()
    
    private let loginButton = createCustomButton(
        title: Localizable.signInButton,
        titleColor: .white,
        backgroundColor: .candyAppleRed
    )
    
    private let continueAsGuestButton = createCustomButton(
        title: Localizable.continueAsGuestButton,
        titleColor: .slateGray,
        backgroundColor: .flashWhite
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkPurple
        loginButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        setupLayout()
        setupTextChangedHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        initializeHideKeyboard()
        subscribeToNotification(UIResponder.keyboardWillChangeFrameNotification,
                                selector: #selector(handleKeyboard(notification:)))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        unsubscribeFromAllNotifications()
    }
    
    static func createCustomButton(title: String, titleColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = TextStyle.header
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25.0
        return button
    }
}

private extension LoginViewController {
    @objc func didTapSignIn() {
        guard !enteredEmail.isEmpty, !enteredPassword.isEmpty else {
            showAlert(title: Localizable.loginFailedLabel, message: Localizable.loginFailedMessageForEmptyInput)
            return
        }
        
        guard let savedPassword = AuthCredentials.validLogins[enteredEmail], savedPassword == enteredPassword else {
            showAlert(title: Localizable.loginFailedLabel, message: Localizable.loginFailedMessageForErrorInput)
            return
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupTextChangedHandlers() {
        emailInput.onTextChanged = { [weak self] text in
            self?.enteredEmail = text
        }
        
        passwordInput.onTextChanged = { [weak self] text in
            self?.enteredPassword = text
        }
    }
    
    @objc func handleKeyboard(notification: NSNotification) {
        keyboardWillShowOrHide(notification: notification, scrollView: scrollView)
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
        
        [boatImageView, welcomeLabel, emailInput, passwordInput, loginButton, separatorView, continueAsGuestButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            boatImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            boatImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70.0),
            boatImageView.widthAnchor.constraint(equalToConstant: 100.0),
            boatImageView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: boatImageView.bottomAnchor, constant: 25.0)
        ])
        
        NSLayoutConstraint.activate([
            emailInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emailInput.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 70.0),
            emailInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 35.0),
            passwordInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 110.0),
            loginButton.widthAnchor.constraint(equalToConstant: 360.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 340.0),
        ])
        
        NSLayoutConstraint.activate([
            continueAsGuestButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            continueAsGuestButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20.0),
            continueAsGuestButton.widthAnchor.constraint(equalToConstant: 360.0),
            continueAsGuestButton.heightAnchor.constraint(equalToConstant: 50.0),
            continueAsGuestButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0)
        ])
    }
}
