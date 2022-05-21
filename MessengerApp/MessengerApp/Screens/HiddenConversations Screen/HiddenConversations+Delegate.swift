//
//  HiddenConversations+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 22.03.2022.
//

import UIKit

extension HiddenConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hiddenConversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationsTableViewCell.identifier, for: indexPath) as! ConversationsTableViewCell
        cell.configure(with: hiddenConversations[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete {
            Constants.isActiveNotification = false
            let conversation = hiddenConversations[indexPath.row]
            // delete in UI
            tableView.beginUpdates()
            hiddenConversations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            // unhide in database
            DatabaseManager.shared.unhideConversation(conversation: conversation, completion: { [weak self] success in
                if success {
                    self?.displayAlert(message: "The conversation has been restored.")
                    Constants.isActiveNotification = true
                    self?.updateUI()
                } else {
                    self?.displayAlert(message: "Failed to unhide the message!")
                }
            })
            tableView.endUpdates()
        }
    }
    
}
