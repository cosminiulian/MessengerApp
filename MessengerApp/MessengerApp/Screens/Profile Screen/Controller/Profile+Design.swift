//
//  Profile+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 01.03.2022.
//

import UIKit

extension ProfileViewController: DesignProtocol {
    
    func setupNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(logoutButtonAction))
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
    func setupSubviews() {
        fullNameStackView.addArrangedSubview(fullNameLabel)
        fullNameStackView.addArrangedSubview(fullNameContentLabel)
        emailStackView.addArrangedSubview(emailLabel)
        emailStackView.addArrangedSubview(emailContentLabel)
        
        view.addSubview(profileHeaderView)
        view.addSubview(detailsLabel)
        view.addSubview(fullNameStackView)
        view.addSubview(emailStackView)
    }
    
    func setupConstraints() {
        profileHeaderView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 topConstant: 10,
                                 heightConstant: 250)
        
        detailsLabel.anchor(top: profileHeaderView.bottomAnchor,
                            left: view.leftAnchor,
                            right: view.rightAnchor,
                            topConstant: 20,
                            leftConstant: 15,
                            rightConstant: 15,
                            heightConstant: 25)
        
        fullNameStackView.anchor(top: detailsLabel.bottomAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 topConstant: 10,
                                 leftConstant: 30,
                                 rightConstant: 30,
                                 heightConstant: 25)
        
        emailStackView.anchor(top: fullNameStackView.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              leftConstant: 30,
                              rightConstant: 30,
                              heightConstant: 25)
    }
    
    func setupButtonsMethods() {
        profileHeaderView.addActions(self,
                                     saveAction: #selector(saveButtonAction),
                                     profileAction: #selector(profileTapAction))
    }
    
    func setupString() {
        if let fullName = UserDefaults.standard.value(forKey: Constants.fullName) as? String {
            fullNameContentLabel.text = fullName
        }
        
        if let email = UserDefaults.standard.value(forKey: Constants.userEmail) as? String {
            emailContentLabel.text = email
        }
    }
}
