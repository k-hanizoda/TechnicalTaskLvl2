import Foundation

final class LoginViewModel {
    var enteredEmail: String = ""
    var enteredPassword: String = ""
    
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    func validateLogin() {
        guard !enteredEmail.isEmpty, !enteredPassword.isEmpty else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.onLoginFailure?(Localizable.loginFailedMessageForEmptyInput)
            }
            return
        }
        
        guard let savedPassword = KeychainHelper.shared.getPassword(for: enteredEmail),
              savedPassword == enteredPassword else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.onLoginFailure?(Localizable.loginFailedMessageForErrorInput)
            }
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.onLoginSuccess?()
        }
    }
}
