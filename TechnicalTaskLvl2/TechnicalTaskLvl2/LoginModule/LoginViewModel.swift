import Foundation

final class LoginViewModel {
    var enteredEmail: String = ""
    var enteredPassword: String = ""
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    func validateLogin() {
        guard !enteredEmail.isEmpty, !enteredPassword.isEmpty else {
            onLoginFailure?(Localizable.loginFailedMessageForEmptyInput)
            return
        }
        
        guard let savedPassword = KeychainHelper.shared.getPassword(for: enteredEmail),
              savedPassword == enteredPassword else {
            onLoginFailure?(Localizable.loginFailedMessageForErrorInput)
            return
        }
        
        onLoginSuccess?()
    }
}
