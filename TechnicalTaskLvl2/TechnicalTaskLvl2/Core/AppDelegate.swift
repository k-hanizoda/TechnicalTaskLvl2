import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBarAppearance()
        KeychainHelper.shared.setupInitialCredentials()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
    
    func setupNavigationBarAppearance() {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = UIColor.darkPurple.withAlphaComponent(0.9)
        standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.flashWhite]
        
        let scrollEdgeAppearance = UINavigationBarAppearance()
        scrollEdgeAppearance.backgroundColor = UIColor.darkPurple
        scrollEdgeAppearance.titleTextAttributes = [.foregroundColor: UIColor.flashWhite]
        
        UINavigationBar.appearance().standardAppearance = standardAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        UINavigationBar.appearance().compactAppearance = standardAppearance
    }
}
