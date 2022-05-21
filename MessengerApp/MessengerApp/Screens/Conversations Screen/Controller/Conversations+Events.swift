//
//  Conversations+Events.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 02.03.2022.
//

import UIKit

extension ConversationsViewController {
    
    @objc func composeButtonAction() {
        let newConversationVC = NewConversationViewController()
        newConversationVC.completion = { [weak self] result in
            guard let self = self else {
                return
            }
            if let existingConversation = self.checkIfConversationIsNew(with: result) {
                self.openConversation(existingConversation)
            } else {
                self.createNewConversation(with: result)
            }
        }
        
        let navController = UINavigationController(rootViewController: newConversationVC)
        self.present(navController, animated: true)
    }
    
    @objc func showHiddenConversations() {
        let hiddenConversationsVC = HiddenConversationsViewController(hiddenConversations: hiddenConversations)
        let navController = UINavigationController(rootViewController: hiddenConversationsVC)
        self.present(navController, animated: true)
    }
    
}
