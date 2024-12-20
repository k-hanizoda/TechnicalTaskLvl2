import Foundation

enum Localizable {
    static let emailLabel = NSLocalizedString("email_label", comment: "Label for email input")
    static let passwordLabel = NSLocalizedString("password_label", comment: "Label for password input")
    
    static let emailPlaceholder = NSLocalizedString("email_placeholder", comment: "Placeholder for email input")
    static let passwordPlaceholder = NSLocalizedString("password_placeholder", comment: "Placeholder for password input")
    
    static let welcomeLabel = NSLocalizedString("welcome_label", comment: "Label for welcome text")
    static let signInButton = NSLocalizedString("sign_in_button", comment: "Button text for signing in")
    static let continueAsGuestButton = NSLocalizedString("continue_as_guest_button", comment: "Button text for signing in as guest")
    static let orLabel = NSLocalizedString("or_label", comment: "Label for or text")
    static let invalidEmailLabel = NSLocalizedString("invalid_email_label", comment: "Label for invalid email text")
    
    static let loginFailedLabel = NSLocalizedString("login_failed_label", comment: "Label for login failed text for empty input")
    static let loginFailedMessageForEmptyInput = NSLocalizedString("login_failed_message_for_empty_input", comment: "Message for login failed text for empty input")
    static let loginFailedMessageForErrorInput = NSLocalizedString("login_failed_message_for_error_input", comment: "Message for login failed text for error input")
    static let alertActionOK = NSLocalizedString("alert_action_ok", comment: "Alert action OK text")
}
