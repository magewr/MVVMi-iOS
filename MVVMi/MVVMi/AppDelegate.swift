//
//  AppDelegate.swift
//  MVVMi
//
//  Created by UramMyeongbu on 2020/10/08.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        mainViewController?.viewModel = MainViewModel(dependency: MainViewModel.Dependency(quotesInteractor: QuotesInteractor(client: RestClient())))
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }



}

