//
//  AppDelegate.swift
//  SearchAndPlaces
//
//  Created by Евгения Шарамет on 09.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainNavigationController()
        window.makeKeyAndVisible()
        self.window = window
        self.window?.backgroundColor = UIColor.red
        return true
    }
}
