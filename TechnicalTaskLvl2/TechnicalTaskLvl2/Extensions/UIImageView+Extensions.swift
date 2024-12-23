import UIKit

extension UIImageView {
    func loadFromURL(_ url: URL?) async {
        guard let url else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        } catch {
            debugPrint(ImageLoadingError.failedToCreateImage)
        }
    }
}
