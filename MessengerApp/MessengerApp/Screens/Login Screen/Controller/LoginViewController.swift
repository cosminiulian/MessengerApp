//
//  LoginViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import JGProgressHUD

class LoginViewController: UIViewController {
    
    let spinner = JGProgressHUD(style: .dark)
    
    let loginView: LoginView = {
        let loginView = LoginView()
        loginView.layer.cornerRadius = 10
        loginView.backgroundColor = .link
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        loginView.setupDelegates(self)
        //autocompleteFields()
    }
    
    private func autocompleteFields() {
        loginView.emailTextField.text = "cosmin@mail.com"
        loginView.passwordTextField.text = "1234567"
    }
    
}
