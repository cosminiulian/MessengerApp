//
//  NewConversation+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 02.03.2022.
//

import UIKit

extension NewConversationViewController: DesignProtocol {
    
    func setupNavController() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .done,
            target: self,
            action: #selector(cancelButtonAction))
    }
    
    func setupSubviews() {
        view.addSubview(noResultsLabel)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        noResultsLabel.anchorToCenterXAndY(centerX: view.centerXAnchor,
                                           centerY: view.centerYAnchor)
        
        tableView.anchor(top: view.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.bottomAnchor,
                         right: view.rightAnchor)
    }
    
    func setupButtonsMethods() { }
    
}
