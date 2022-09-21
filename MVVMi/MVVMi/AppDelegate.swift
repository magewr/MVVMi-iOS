import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainViewController = MainViewController()
        mainViewController.viewModel = MainViewModel(dependency: MainViewModel.Dependency(quotesInteractor: QuotesInteractor(client: RestClient())))
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }



}

