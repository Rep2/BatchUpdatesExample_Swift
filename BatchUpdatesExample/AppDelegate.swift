//
//  AppDelegate.swift
//  BatchUpdatesExample
//
//  Created by Ivan Rep on 17/04/2017.
//  Copyright © 2017 undabot. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController(
            rootViewController: StartingViewController(nibName: nil, bundle: nil)
        )

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

