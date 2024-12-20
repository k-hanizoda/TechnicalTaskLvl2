enum TextFieldType {
    case email
    case password
    
    var labelText: String {
        switch self {
        case .email:
            return Localizable.emailLabel
        case .password:
            return Localizable.passwordLabel
        }
    }
    
    var placeholder: String {
        switch self {
        case .email:
            return Localizable.emailPlaceholder
        case .password:
            return Localizable.passwordPlaceholder
        }
    }
    
    var systemImageName: String {
        switch self {
        case .email:
            return "envelope.fill"
        case .password:
            return "lock.fill"
        }
    }
    
    var isSecure: Bool {
        switch self {
        case .email:
            return false
        case .password:
            return true
        }
    }
    
    var showVisibilityToggle: Bool {
        switch self {
        case .email:
            return false
        case .password:
            return true
        }
    }
}
