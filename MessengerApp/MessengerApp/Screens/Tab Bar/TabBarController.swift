//
//  TabBarController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 01.03.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupTabBarStyling()
        setupViewControllers()
    }
    
    private func setupTabBarStyling() {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .secondarySystemBackground
        tabBar.tintColor = .link
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupViewControllers() {
        viewControllers = [
            createNavController(for: ConversationsViewController(), title: "Conversations", image: UIImage(named: "ChatTabIcon")!),
            createNavController(for: ProfileViewController(), title: "Profile", image: UIImage(named: "ProfileTabIcon")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.hidesBackButton = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
