//
//  AppDelegate.swift
//  goodies
//
//  Created by Mac on 10/13/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = mainStoryboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = initialViewController
        return true
    }
}

