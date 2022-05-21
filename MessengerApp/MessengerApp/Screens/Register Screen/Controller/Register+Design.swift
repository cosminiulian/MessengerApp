//
//  Register+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

extension RegisterViewController: DesignProtocol {
    
    func setupNavController() {
        title = "Create an account"
    }
    
    func setupSubviews() {
        view.addSubview(registerView)
    }
    
    func setupConstraints() {
        registerView.anchorToCenterY(left: view.leftAnchor,
                                     right: view.rightAnchor,
                                     leftConstant: 20,
                                     rightConstant: 20,
                                     heightConstant: 560,
                                     centerY: view.centerYAnchor)
    }
    
    func setupButtonsMethods() {
        registerView.addActions(self,
                                registerAction: #selector(registerButtonAction),
                                profileAction: #selector(profileTapAction))
    }
    
}
