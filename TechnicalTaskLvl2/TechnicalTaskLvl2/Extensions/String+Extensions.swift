import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailPattern = "^(?=[^@]{1,254}$)(?!.*@.*@)(?!.*\\.{2})[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,63}$|^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[\\p{L}]{2,63}$"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: self)
    }
}
