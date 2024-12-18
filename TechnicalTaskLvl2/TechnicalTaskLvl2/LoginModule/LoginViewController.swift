import UIKit

final class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .Main
        
        let emailTextField = CustomTextField(
            placeholder: "Email",
            systemImageName: "envelope.fill",
            isSecure: false,
            showVisibilityToggle: false
        )
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailTextField.widthAnchor.constraint(equalToConstant: 360),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let passwordTextField = CustomTextField(
            placeholder: "Password",
            systemImageName: "lock.fill",
            isSecure: true,
            showVisibilityToggle: true
        )
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 360),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
