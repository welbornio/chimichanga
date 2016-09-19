//
//  AppDelegate.swift
//  chimichanga
//
//  Created by shake on 9/13/16.
//  Copyright © 2016 welbornio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = UIColor.white
        
        let mainViewController = MainViewController()
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [mainViewController]
        
        window!.rootViewController = navigationController
        
        window!.makeKeyAndVisible()
        
        return true
    }
    
}

