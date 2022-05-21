//
//  RegisterViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import JGProgressHUD

class RegisterViewController: UIViewController {

    let spinner = JGProgressHUD(style: .dark)
    
    let registerView: RegisterView = {
        let registerView = RegisterView()
        registerView.layer.cornerRadius = 10
        registerView.backgroundColor = .link
        return registerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        registerView.setupDelegates(self)
        //autocompleteFields()
    }
    
    private func autocompleteFields() {
        registerView.fullNameTextField.text = "Cosmin Iulian"
        registerView.emailTextField.text = "cosmin@mail.com"
        registerView.passwordTextField.text = "1234567"
        registerView.confirmPasswordTextField.text = "1234567"
    }

}
