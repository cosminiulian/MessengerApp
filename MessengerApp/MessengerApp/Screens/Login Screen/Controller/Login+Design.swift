//
//  Login+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

extension LoginViewController: DesignProtocol {
    
    func setupNavController() { }
    
    func setupSubviews() {
        view.addSubview(loginView)
    }
    
    func setupConstraints() {
        loginView.anchorToCenterY(left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  leftConstant: 20,
                                  rightConstant: 20,
                                  heightConstant: 520,
                                  centerY: view.centerYAnchor)
    }
    
    func setupButtonsMethods() {
        loginView.addActions(self,
                             loginAction: #selector(loginButtonAction),
                             createAccountAction: #selector(createAccountButtonAction))
    }
    
}
