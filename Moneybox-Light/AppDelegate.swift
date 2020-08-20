//
//  AppDelegate.swift
//  Moneybox-Light
//
//  Created by Pete Holdsworth on 18/08/2020.
//  Copyright © 2020 Pete Holdsworth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }
    
    fileprivate func configureWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootNavController = CustomNavigationController()
        
        let userAccountsPresenter = UserAccountsPresenter(dao: DataAccessObjectImpl.shared)
        let userAccountsViewController = UserAccountsViewController(presenter: userAccountsPresenter)
        rootNavController.addChild(userAccountsViewController)
        
        window.makeKeyAndVisible()
        window.rootViewController = rootNavController
        self.window = window
    }

}
