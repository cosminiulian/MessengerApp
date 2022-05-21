//
//  LoginView.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

class LoginView: UIView {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoIcon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Email address:"
        label.textColor = .white
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Email address"
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Password:"
        label.textColor = .white
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .go
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.tertiarySystemBackground, for: .normal)
        button.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let separatorView = LoginSeparatorView()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font =  .boldSystemFont(ofSize: 18)
        button.setTitle("Create New Account", for: .normal)
        button.setTitleColor(.tertiarySystemBackground, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil {
            setupSubviews()
            setupConstraints()
        }
    }
    
    private func setupSubviews() {
        addSubview(logoImageView)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(separatorView)
        addSubview(createAccountButton)
    }
    
    private func setupConstraints() {
        logoImageView.anchorToCenterX(top: topAnchor,
                                      topConstant: 20,
                                      widthConstant: 100,
                                      heightConstant: 100,
                                      centerX: centerXAnchor)
        
        emailLabel.anchor(top: logoImageView.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          leftConstant: 20,
                          rightConstant: 20,
                          heightConstant: 40)
        
        emailTextField.anchor(top: emailLabel.bottomAnchor,
                              left: leftAnchor,
                              right: rightAnchor,
                              leftConstant: 20,
                              rightConstant: 20,
                              heightConstant: 40)
        
        passwordLabel.anchor(top: emailTextField.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             topConstant: 10,
                             leftConstant: 20,
                             rightConstant: 20,
                             heightConstant: 40)
        
        passwordTextField.anchor(top: passwordLabel.bottomAnchor,
                                 left: leftAnchor,
                                 right: rightAnchor,
                                 leftConstant: 20,
                                 rightConstant: 20,
                                 heightConstant: 40)
        
        loginButton.anchor(top: passwordTextField.bottomAnchor,
                           left: leftAnchor,
                           right: rightAnchor,
                           topConstant: 20,
                           leftConstant: 20,
                           rightConstant: 20,
                           heightConstant: 60)
        
        separatorView.anchor(top: loginButton.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             topConstant: 20,
                             leftConstant: 20,
                             rightConstant: 20,
                             heightConstant: 20)
        
        createAccountButton.anchor(top: separatorView.bottomAnchor,
                                   left: leftAnchor,
                                   right: rightAnchor,
                                   topConstant: 20,
                                   leftConstant: 50,
                                   rightConstant: 50,
                                   heightConstant: 60)
    }
    
    func addActions(_ viewController: LoginViewController, loginAction: Selector, createAccountAction: Selector) {
        loginButton.addTarget(viewController, action: loginAction, for: .touchUpInside)
        createAccountButton.addTarget(viewController, action: createAccountAction, for: .touchUpInside)
    }
    
    func setupDelegates(_ viewController: LoginViewController) {
        emailTextField.delegate = viewController
        passwordTextField.delegate = viewController
    }
    
}
