import Foundation

final class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}
    
    func setupInitialCredentials() {
        let predefinedLogins: [String: String] = [
            "user@ex.com": "123",
            "user@gmail.com": "qwerty"
        ]
        
        for (email, password) in predefinedLogins {
            saveCredentials(email: email, password: password)
        }
    }
    
    func saveCredentials(email: String, password: String) {
        let data = password.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecValueData as String: data
        ]
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func getPassword(for email: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
