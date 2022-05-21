//
//  AppDelegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootViewController: UIViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupFirebase()
        setupIQKeyboardManager()
        setupNavBarAppearance()
        setupRootVC()
        setupNotificationsAuthorization()
        //startNetworkMonitoring()
        //UIApplication.shared.applicationIconBadgeNumber = 0
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if !Reachability.isConnectedToNetwork() {
            displayNoInternetAlert()
        }
    }
    
//    func applicationWillTerminate(_ application: UIApplication) {
//        stopNetworkMonitoring()
//    }
    
    
    /// set orientations you want to be allowed in this property by default
    var orientationLock: UIInterfaceOrientationMask = .portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return orientationLock
    }
    
}
