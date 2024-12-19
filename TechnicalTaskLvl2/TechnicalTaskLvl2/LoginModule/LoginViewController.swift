import UIKit

final class LoginViewController: UIViewController {
    private let boatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sailboat.fill")
        imageView.tintColor = UIColor.white.withAlphaComponent(0.7)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = Localizable.welcomeLabel
        label.textColor = UIColor.white.withAlphaComponent(0.8)
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
        setupLayout()
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
    func setupLayout() {
        boatImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boatImageView)
        NSLayoutConstraint.activate([
            boatImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boatImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            boatImageView.widthAnchor.constraint(equalToConstant: 100.0),
            boatImageView.heightAnchor.constraint(equalToConstant: 100.0)
        ])
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: boatImageView.bottomAnchor, constant: 25.0)
        ])
        
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailInput)
        NSLayoutConstraint.activate([
            emailInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailInput.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 60.0),
            emailInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordInput)
        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 20.0),
            passwordInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 100.0),
            loginButton.widthAnchor.constraint(equalToConstant: 360.0),
            loginButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20.0),
            separatorView.widthAnchor.constraint(equalToConstant: 340.0),
        ])
        
        continueAsGuestButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(continueAsGuestButton)
        NSLayoutConstraint.activate([
            continueAsGuestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueAsGuestButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20.0),
            continueAsGuestButton.widthAnchor.constraint(equalToConstant: 360.0),
            continueAsGuestButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}
