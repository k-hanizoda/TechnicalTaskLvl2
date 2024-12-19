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
        label.textColor = UIColor.white.withAlphaComponent(0.8)
        TextStyle.applyDynamicType(to: label, font: TextStyle.header)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = Localizable.welcomeLabel
        return label
    }()
    
    private let emailInput = LabeledInputField(type: .email)
    private let passwordInput = LabeledInputField(type: .password)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Main
        setupLayout()
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
            emailInput.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40.0),
            emailInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordInput)
        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 20.0),
            passwordInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
    }
}
