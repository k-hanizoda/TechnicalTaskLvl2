import UIKit

final class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Main
        setupInputFields()
    }
}

private extension LoginViewController {
    func setupInputFields() {
        let emailInput = LabeledInputField(type: .email)
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailInput)
        NSLayoutConstraint.activate([
            emailInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailInput.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100.0),
            emailInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
        
        let passwordInput = LabeledInputField(type: .password)
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordInput)
        NSLayoutConstraint.activate([
            passwordInput.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 20.0),
            passwordInput.widthAnchor.constraint(equalToConstant: 360.0)
        ])
    }
}
