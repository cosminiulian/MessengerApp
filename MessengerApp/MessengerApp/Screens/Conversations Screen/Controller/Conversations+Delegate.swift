//
//  Conversations+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 01.03.2022.
//

import UIKit

extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationsTableViewCell.identifier, for: indexPath) as! ConversationsTableViewCell
        cell.configure(with: conversations[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversation = conversations[indexPath.row]
        openConversation(conversation)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            isFirstTime = true // to not show notifications on changes
            let conversation = conversations[indexPath.row]
            // delete in UI
            tableView.beginUpdates()
            conversations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            // hide in database
            DatabaseManager.shared.hideConversation(conversation: conversation, completion: { [weak self] success in
                if success {
                    self?.displayAlert(message: "The conversation has been hidden!")
                    Constants.isActiveNotification = true
                } else {
                    self?.displayAlert(message: "Failed to hide the message!")
                }
            })
            tableView.endUpdates()
        }
    }
    
}
