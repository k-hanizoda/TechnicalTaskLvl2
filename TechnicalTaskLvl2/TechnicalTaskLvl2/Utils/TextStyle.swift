import UIKit

struct TextStyle {
    static let header: UIFont = UIFont.preferredFont(forTextStyle: .headline)
    static let body: UIFont = UIFont.preferredFont(forTextStyle: .body)
    static let description: UIFont = UIFont.preferredFont(forTextStyle: .subheadline)
    
    static func applyDynamicType(to label: UILabel, font: UIFont) {
        label.font = font
        label.adjustsFontForContentSizeCategory = true
    }
}
