//
//  RegisterView.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

class RegisterView: UIView {
    
    private let penImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PenIcon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DefaultProfilePicture")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Full name:"
        label.textColor = .white
        return label
    }()
    
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Full name"
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        return textField
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
        textField.returnKeyType = .continue
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        return textField
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.text = "Confirm password:"
        label.textColor = .white
        return label
    }()
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .join
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "Confirm password"
        textField.isSecureTextEntry = true
        textField.backgroundColor = .tertiarySystemBackground
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(20)
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font =  .boldSystemFont(ofSize: 18)
        button.setTitle("Register", for: .normal)
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
        addSubview(penImageView)
        addSubview(profileImageView)
        addSubview(fullNameLabel)
        addSubview(fullNameTextField)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(confirmPasswordLabel)
        addSubview(confirmPasswordTextField)
        addSubview(registerButton)
    }
    
    private func setupConstraints() {
        penImageView.anchor(top: topAnchor,
                            left: profileImageView.rightAnchor,
                            topConstant: 20,
                            widthConstant: 15,
                            heightConstant: 15)
        
        profileImageView.anchorToCenterX(top: topAnchor,
                                         topConstant: 20,
                                         widthConstant: 80,
                                         heightConstant: 80,
                                         centerX: centerXAnchor)
        
        fullNameLabel.anchor(top: profileImageView.bottomAnchor,
                             left: leftAnchor,
                             right: rightAnchor,
                             leftConstant: 20,
                             rightConstant: 20,
                             heightConstant: 40)
        
        fullNameTextField.anchor(top: fullNameLabel.bottomAnchor,
                                 left: leftAnchor,
                                 right: rightAnchor,
                                 leftConstant: 20,
                                 rightConstant: 20,
                                 heightConstant: 40)
        
        emailLabel.anchor(top: fullNameTextField.bottomAnchor,
                          left: leftAnchor,
                          right: rightAnchor,
                          topConstant: 10,
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
        
        confirmPasswordLabel.anchor(top: passwordTextField.bottomAnchor,
                                    left: leftAnchor,
                                    right: rightAnchor,
                                    topConstant: 10,
                                    leftConstant: 20,
                                    rightConstant: 20,
                                    heightConstant: 40)
        
        confirmPasswordTextField.anchor(top: confirmPasswordLabel.bottomAnchor,
                                        left: leftAnchor,
                                        right: rightAnchor,
                                        leftConstant: 20,
                                        rightConstant: 20,
                                        heightConstant: 40)
        
        registerButton.anchor(top: confirmPasswordTextField.bottomAnchor,
                              left: leftAnchor,
                              right: rightAnchor,
                              topConstant: 20,
                              leftConstant: 20,
                              rightConstant: 20,
                              heightConstant: 60)
    }
    
    func addActions(_ viewController: RegisterViewController, registerAction: Selector, profileAction: Selector) {
        registerButton.addTarget(viewController, action: registerAction, for: .touchUpInside)
        
        let profileTapGesture = UITapGestureRecognizer(target: viewController, action: profileAction)
        profileImageView.addGestureRecognizer(profileTapGesture)
        profileImageView.isUserInteractionEnabled = true
    }
    
    func setupDelegates(_ viewController: RegisterViewController) {
        fullNameTextField.delegate = viewController
        emailTextField.delegate = viewController
        passwordTextField.delegate = viewController
        confirmPasswordTextField.delegate = viewController
    }
    
}
