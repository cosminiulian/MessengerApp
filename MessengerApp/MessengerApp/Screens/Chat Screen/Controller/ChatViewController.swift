//
//  ChatViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 01.03.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import JGProgressHUD

class ChatViewController: MessagesViewController {
    
    public var completion: ((String?) -> (Void))?
    
    let spinner = JGProgressHUD(style: .dark)
    
    var senderPhotoURL: URL?
    var otherUserPhotoURL: URL?
    var isNewConversation = false
    let otherUser: User
    var conversationId: String?
    var messages = [Message]()
    var sender: Sender? {
        guard let email = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            return nil
        }
        return Sender(senderId: email, displayName: "Me", photoURL: "")
    }
    
    init(with otherUser: User, id: String?) {
        self.conversationId = id
        self.otherUser = otherUser
        super.init(nibName: nil, bundle: nil)
        hidesBottomBarWhenPushed = true
        
        if let conversationId = conversationId {
            listenForMessages(id: conversationId, shouldScrollToBottom: true)
        }
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
        setupDelegates()
        setupInputButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Constants.isActiveNotification = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Constants.isActiveNotification = true
        
        if isMovingFromParent {
            completion?(conversationId)
        }
    }
    
    func setupDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messageCellDelegate = self
        messageInputBar.delegate = self
    }
    
    func setupInputButton() {
        if !isNewConversation {
            let button = InputBarButtonItem()
            button.setSize(CGSize(width: 35, height: 35), animated: false)
            button.setImage(UIImage(systemName: "paperclip"), for: .normal)
            button.onTouchUpInside({ [weak self] _ in
                self?.presentInputActionSheet()
            })
            messageInputBar.setLeftStackViewWidthConstant(to: 36, animated: false)
            messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
        }
    }
    
    
    func createMessageId() -> String? {
        guard let currentUserEmail = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            return nil
        }
        let newId = IdGenerator.shared.generateMessageId(senderEmail: currentUserEmail,
                                                         otherUserEmail: otherUser.email)
        print("Created message id: \(newId)")
        return newId
    }
    
    func listenForMessages(id: String, shouldScrollToBottom: Bool) {
        DatabaseManager.shared.getAllMessagesForConversation(with: id, completion: { [weak self] result in
            
            switch result {
            case .success(let messages):
                guard !messages.isEmpty else {
                    return
                }
                self?.messages = messages
                DispatchQueue.main.async {
                    self?.messagesCollectionView.reloadDataAndKeepOffset()
                    if shouldScrollToBottom {
                        self?.messagesCollectionView.scrollToLastItem()
                    }
                }
                
            case .failure(let error):
                print("Failed to get messages: \(error)")
            }
            
        })
    }
    
}
