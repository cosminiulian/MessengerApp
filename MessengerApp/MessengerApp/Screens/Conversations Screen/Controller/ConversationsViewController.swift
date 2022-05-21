//
//  ViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import JGProgressHUD
import AVFoundation
import UserNotifications

class ConversationsViewController: UIViewController {
    var isFirstTime: Bool = true
    
    var conversations = [Conversation]()
    var hiddenConversations = [Conversation]()
    
    let spinner = JGProgressHUD(style: .dark)
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        startListeningForConversations()
        
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        setupTableView()
    }
    
    func startListeningForConversations() {
        guard let userEmail = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            return
        }
        spinner.show(in: view)
        
        DatabaseManager.shared.getAllConversations(for: userEmail, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            self.spinner.dismiss(animated: true)
            
            switch result {
            case .success(let conversations):
                self.setupConversations(allConversations: conversations)
                self.updateUI()
                if Constants.isActiveNotification && self.isFirstTime == false {
                    self.sendNotification()
                } else {
                    self.isFirstTime = false
                }
                
            case .failure(let error):
                self.displayAlert(title: "Failed to get conversations", message: error.localizedDescription)
                self.spinner.dismiss(animated: true)
            }
        })
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createNewConversation(with otherUser: User) {
        let chatVC = ChatViewController(with: otherUser, id: nil)
        chatVC.isNewConversation = true
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func checkIfConversationIsNew(with user: User) -> Conversation? {
        let conversationsFound = conversations.first(where: {
            $0.otherUserEmail == user.email
        })
        
        if conversationsFound == nil {
            return hiddenConversations.first(where: {
                $0.otherUserEmail == user.email
            })
        }
        return conversationsFound
    }
    
    func openConversation(_ conversation: Conversation) {
        let otherUser = User(fullName: conversation.otherUserFullName,
                             email: conversation.otherUserEmail)
        let chatVC = ChatViewController(with: otherUser, id: conversation.id)
        
        if !conversation.latestMessage.isRead {
            chatVC.completion = { [weak self] conversationId in
                if let id = conversationId {
                    if let conv = self?.getConversation(by: id) {
                        self?.isFirstTime = true // to not show notifications on changes
                        DatabaseManager.shared.readConversation(conversation: conv, completion: { [weak self] succes in
                            if !succes {
                                self?.displayAlert(message: "Failed to set conversation as read..")
                            }
                        })
                    }
                }
            }
        }
        
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func setupConversations(allConversations: [Conversation]) {
        conversations = allConversations.filter { $0.isHidden == false }
        hiddenConversations = allConversations.filter{ $0.isHidden == true }
    }
    
    func updateUI() {
        if !conversations.isEmpty {
            tableView.isHidden = false
            noConversationsLabel.isHidden = true
            tableView.reloadData()
        }
        else {
            tableView.isHidden = true
            noConversationsLabel.isHidden = false
        }
    }
    
    func sendNotification() {
        LocalNotificationHelper.showNotification(title: "New message",
                                                 subtitle: "",
                                                 body: "You have a new message.",
                                                 identifier: Bundle.main.bundleIdentifier!)
    }
    
    private func getConversation(by id: String) -> Conversation? {
        for conversation in conversations {
            if conversation.id == id {
                return conversation
            }
        }
        return nil
    }
    
}
