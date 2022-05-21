//
//  AppDelegate+Extension.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 21.03.2022.
//

import Firebase
import FirebaseCrashlytics
import IQKeyboardManagerSwift

extension AppDelegate {
    
    func setupFirebase() {
        FirebaseApp.configure()
    }
    
    func setupCrashlytics() {
        Crashlytics.initialize()
    }
    
    func setupIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        //IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Cancel"
        IQKeyboardManager.shared.disabledDistanceHandlingClasses.append(ChatViewController.self)
    }
    
    func setupNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func setupNotificationsAuthorization() {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in })
    }
    
    func setupRootVC() {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            rootViewController = TabBarController()
        } else {
            rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    func displayNoInternetAlert() {
        let alert = UIAlertController(title: "No internet connection :(",
                                      message: "Please reopen the application when you have internet.",
                                      preferredStyle: .actionSheet)
        window!.rootViewController!.present(alert, animated: true)
    }
    
}
