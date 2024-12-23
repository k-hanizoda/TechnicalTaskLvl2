import UIKit

final class LoginViewController: UIViewController {
    private var viewModel: LoginViewModel
    var navigateToShipList: ((UserMode) -> Void)?
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white.withAlphaComponent(0.7)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
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
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not implemented. Use the custom initializer to instantiate this view controller programmatically.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkPurple
        setupButtonActions()
        setupLayout()
        configureBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        initializeHideKeyboard()
        subscribeToNotification(UIResponder.keyboardWillChangeFrameNotification,
                                selector: #selector(handleKeyboard(notification:)))
        emailInput.clearInput()
        passwordInput.clearInput()
        loadingIndicator.stopAnimating()
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
    func setupButtonActions() {
        loginButton.addTarget(self, action: #selector(buttonTappedWithAnimation(_:)), for: .touchUpInside)
        continueAsGuestButton.addTarget(self, action: #selector(buttonTappedWithAnimation(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTappedWithAnimation(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = .identity
            })
        }
        
        loadingIndicator.startAnimating()
        
        switch sender {
        case loginButton:
            viewModel.validateLogin()
        case continueAsGuestButton:
            navigateToShipList?(.guest)
        default:
            break
        }
    }
    
    func configureBindings() {
        setupTextChangedHandlers()
        
        viewModel.onLoginFailure = { [weak self] errorMessage in
            self?.loadingIndicator.stopAnimating()
            self?.showAlert(title: Localizable.loginFailedLabel, message: errorMessage)
        }
        
        viewModel.onLoginSuccess = { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.navigateToShipList?(.user)
        }
    }
    
    func setupTextChangedHandlers() {
        emailInput.onTextChanged = { [weak self] text in
            self?.viewModel.enteredEmail = text
            self?.updateLoginButtonState()
        }
        
        passwordInput.onTextChanged = { [weak self] text in
            self?.viewModel.enteredPassword = text
            self?.updateLoginButtonState()
        }
    }
    
    func updateLoginButtonState() {
        let isEmailValid = viewModel.enteredEmail.isValidEmail()
        let isPasswordValid = !viewModel.enteredPassword.isEmpty
        
        loginButton.isEnabled = isEmailValid && isPasswordValid
        loginButton.alpha = loginButton.isEnabled ? 1.0 : 0.5
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
        
        boatImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(boatImageView)
        NSLayoutConstraint.activate([
            boatImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            boatImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70.0),
            boatImageView.widthAnchor.constraint(equalToConstant: 100.0),
            boatImageView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: boatImageView.bottomAnchor, constant: 25.0)
        ])
        
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailInput)
        NSLayoutConstraint.activate([
            emailInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emailInput.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 70.0),
            emailInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(passwordInput)
        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 35.0),
            passwordInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 110.0),
            loginButton.widthAnchor.constraint(equalToConstant: 360.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 340.0),
        ])
        
        continueAsGuestButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(continueAsGuestButton)
        NSLayoutConstraint.activate([
            continueAsGuestButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            continueAsGuestButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20.0),
            continueAsGuestButton.widthAnchor.constraint(equalToConstant: 360.0),
            continueAsGuestButton.heightAnchor.constraint(equalToConstant: 50.0),
            continueAsGuestButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0)
        ])
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
