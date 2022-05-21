//
//  Conversations+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.02.2022.
//

import UIKit

extension ConversationsViewController: DesignProtocol {
    
    func setupNavController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: #selector(composeButtonAction))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "eye.slash"),
            style: .plain,
            target: self,
            action: #selector(showHiddenConversations))
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
