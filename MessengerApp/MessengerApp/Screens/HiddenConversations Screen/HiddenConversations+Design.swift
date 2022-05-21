//
//  HiddenConversations+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 22.03.2022.
//

import UIKit

extension HiddenConversationsViewController: DesignProtocol {
    
    func setupNavController() {
        title = "Hidden Conversations"
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
    }
    
    func setupConstraints() {
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
        
        noConversationsLabel.anchorToCenterXAndY(centerX: view.centerXAnchor,
                                                 centerY: view.centerYAnchor)
    }
    
    func setupButtonsMethods() { }
    
}
