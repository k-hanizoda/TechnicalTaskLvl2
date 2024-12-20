import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailPattern = "^(?=[a-zA-Z0-9@._%+-]{1,254}$)(?!.*@.*@)(?!.*\\.{2})[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+(?:\\.[a-zA-Z0-9-]{2,})+$"
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        if !emailPredicate.evaluate(with: self) {
            return false
        }
        
        let components = self.split(separator: "@")
        if let domain = components.last, let firstCharacter = domain.first {
            if firstCharacter.isNumber {
                return false
            }
        }
        
        return true
    }
}
