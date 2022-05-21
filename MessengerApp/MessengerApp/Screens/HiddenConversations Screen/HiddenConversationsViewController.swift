//
//  HiddenConversationsViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 22.03.2022.
//

import UIKit

class HiddenConversationsViewController: UIViewController {
    
    var hiddenConversations = [Conversation]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(ConversationsTableViewCell.self,
                           forCellReuseIdentifier: ConversationsTableViewCell.identifier)
        return tableView
    }()
    
    let noConversationsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No Conversations."
        label.textAlignment = .center
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    init(hiddenConversations: [Conversation]) {
        self.hiddenConversations = hiddenConversations
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        setupTableView()
        updateUI()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateUI() {
        if !hiddenConversations.isEmpty {
            tableView.isHidden = false
            noConversationsLabel.isHidden = true
            tableView.reloadData()
        }
        else {
            tableView.isHidden = true
            noConversationsLabel.isHidden = false
        }
    }
    
}
