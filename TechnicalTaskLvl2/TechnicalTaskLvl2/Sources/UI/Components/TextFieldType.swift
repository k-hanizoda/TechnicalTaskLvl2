enum TextFieldType {
    case email
    case password
    
    var labelText: String {
        switch self {
        case .email: Localizable.emailLabel
        case .password: Localizable.passwordLabel
        }
    }
    
    var placeholder: String {
        switch self {
        case .email: Localizable.emailPlaceholder
        case .password: Localizable.passwordPlaceholder
        }
    }
    
    var systemImageName: String {
        switch self {
        case .email: "envelope.fill"
        case .password: "lock.fill"
        }
    }
    
    var isSecure: Bool {
        switch self {
        case .email: false
        case .password: true
        }
    }
    
    var showVisibilityToggle: Bool {
        switch self {
        case .email: false
        case .password: true
        }
    }
}
