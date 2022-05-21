//
//  NewConversation+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 02.03.2022.
//

import UIKit

extension NewConversationViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // SearchBar Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let queryText = searchBar.text, !queryText.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        usersResult.removeAll()
        spinner.show(in: view)
        searchUsers(query: queryText)
    }
    
    // TableView Delegate & Data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewConversationTableViewCell.identifier, for: indexPath) as! NewConversationTableViewCell
        cell.configure(with: usersResult[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // start conversation
        let targetUserData = usersResult[indexPath.row]
        dismiss(animated: true, completion: { [weak self] in
            self?.completion?(targetUserData)
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
