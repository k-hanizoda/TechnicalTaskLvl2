import UIKit

extension UILabel {
    enum TextStyle {
        case header
        case body
        case description
        case title
    }
    
    func applyStyle(_ style: TextStyle) {
        switch style {
        case .header:
            self.font = UIFont.preferredFont(forTextStyle: .headline)
        case .body:
            self.font = UIFont.preferredFont(forTextStyle: .body)
        case .description:
            self.font = UIFont.preferredFont(forTextStyle: .subheadline)
        case .title:
            self.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 14))
        }
        
        self.adjustsFontForContentSizeCategory = true
    }
}
