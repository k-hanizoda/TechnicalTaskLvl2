import UIKit

extension UIViewController {
    func initializeHideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification, scrollView: UIScrollView) {
        guard let userInfo = notification.userInfo,
              let keyboardFrameValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let animationCurveRawValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else {
            return
        }

        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = view.bounds.height - keyboardFrame.origin.y

        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight

        let animationOptions = UIView.AnimationOptions(rawValue: animationCurveRawValue.uintValue << 16)
        UIView.animate(withDuration: animationDuration.doubleValue,
                       delay: 0,
                       options: animationOptions,
                       animations: {
            self.view.layoutIfNeeded()
        })
    }
}
