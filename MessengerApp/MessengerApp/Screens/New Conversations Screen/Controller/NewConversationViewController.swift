//
//  NewConversationViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    
    public var completion: ((User) -> (Void))?
    
    var users = [User]()
    var usersResult = [User]()
    var hasFetched = false
    
    let spinner = JGProgressHUD(style: .dark)
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search by email.."
        return searchBar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(NewConversationTableViewCell.self,
                           forCellReuseIdentifier: NewConversationTableViewCell.identifier)
        return tableView
    }()
    
    let noResultsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Custom method for searching users
    func searchUsers(query: String) {
        // check if array has firebase results
        if hasFetched {
            // if it does: filter
            filterUsers(with: query)
        }
        else {
            // if not: fetch data then filter
            DatabaseManager.shared.getUsers(completion: { [weak self] result in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let users):
                    self.users = users
                    self.hasFetched = true
                    self.filterUsers(with: query)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
    // Custom method for filtering users
    func filterUsers(with term: String) {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: Constants.userEmail) as? String,
              hasFetched else {
            return
        }
        
        spinner.dismiss()
        
        let usersResult: [User] = self.users.filter({
            if $0.email == currentUserEmail { return false }
            let fullName = $0.fullName.lowercased()
            return fullName.hasPrefix(term.lowercased())
        })
        self.usersResult = usersResult
        
        updateUI()
    }
    
    // Update the UI
    func updateUI() {
        if usersResult.isEmpty {
            noResultsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noResultsLabel.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
}
