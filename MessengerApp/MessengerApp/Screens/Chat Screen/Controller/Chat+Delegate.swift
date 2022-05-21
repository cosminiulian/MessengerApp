//
//  Chat+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 02.03.2022.
//

import MessageKit
import InputBarAccessoryView
import SDWebImage
import AVKit


// MARK: - MessageKit: Messages Delegate

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    
    func currentSender() -> SenderType {
        if let sender = sender {
            return sender
        }
        fatalError("Sender is nil because of email..")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func configureMediaMessageImageView(_ imageView: UIImageView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        guard let message = message as? Message else {
            return
        }
        
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {
                return
            }
            imageView.sd_setImage(with: imageUrl)
            
        default:
            break
        }
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let messageSender = message.sender
        if messageSender.senderId == self.sender?.senderId {
            // our message that we've sent
            return .link
        }
        return .secondarySystemBackground
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let messageSender = message.sender
        if messageSender.senderId == self.sender?.senderId {
            // set avatar image for sender
            if let currentUserImageURL = self.senderPhotoURL {
                avatarView.sd_setImage(with: currentUserImageURL)
                
            } else {
                guard let userEmail = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
                    return
                }
                // create path
                let fileName = "\(userEmail)_profile_picture.png"
                let path = "images/" + fileName
                // fetch url
                StorageManager.shared.getDownloadURL(for: path, completion: { [weak self] result in
                    switch result {
                    case .success(let url):
                        // save URL for the next time (we are reducing nr of request in that way)
                        self?.senderPhotoURL = url
                        DispatchQueue.main.async {
                            avatarView.sd_setImage(with: url)
                        }
                    case .failure(let error):
                        print("Error getting download url.. \(error.localizedDescription)")
                    }
                })
            }
            
        } else {
            // set avatar image for other user
            if let otherUserImageURL = self.otherUserPhotoURL {
                avatarView.sd_setImage(with: otherUserImageURL)
                
            } else {
                let otherUserEmail = self.otherUser.email
                // create path
                let fileName = "\(otherUserEmail)_profile_picture.png"
                let path = "images/" + fileName
                // fetch url
                StorageManager.shared.getDownloadURL(for: path, completion: { [weak self] result in
                    switch result {
                    case .success(let url):
                        // save URL for the next time (we are reducing nr of request in that way)
                        self?.otherUserPhotoURL = url
                        DispatchQueue.main.async {
                            avatarView.sd_setImage(with: url)
                        }
                    case .failure(let error):
                        print("Error getting download url.. \(error.localizedDescription)")
                    }
                })
            }
        }
        
    }
    
}


// MARK: - MessageKit: InputBarAccessoryView Delegate

extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty,
              let messageId = createMessageId() ,
              let sender = sender else {
            return
        }
        
        let message = Message(sender: sender,
                              messageId: messageId,
                              sentDate: Date(),
                              kind: .text(text))
        
        // Send Message
        if isNewConversation {
            // create conversation in database
            DatabaseManager.shared.createNewConversation(with: otherUser,
                                                         firstMessage: message,
                                                         completion: { [weak self] success in
                if success {
                    self?.isNewConversation = false
                    let newConversationId = IdGenerator.shared.generateConversationId(firstMessageId: messageId)
                    self?.conversationId = newConversationId
                    self?.listenForMessages(id: newConversationId, shouldScrollToBottom: true)
                    self?.setupInputButton()
                }
                else {
                    self?.displayAlert(message: "failed to create conversation")
                }
            })
        }
        else {
            guard let conversationId = conversationId else {
                return
            }
            // append to existing conversation data
            DatabaseManager.shared.sendMessage(conversationId: conversationId,
                                               otherUser: otherUser,
                                               newMessage: message,
                                               completion: { [weak self] success in
                if !success {
                    self?.displayAlert(message: "failed to send message..")
                }
            })
        }
        
        inputBar.inputTextView.text = nil
    }
}

// MARK: - UIImagePickerController & UINavigationController Delegates

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        spinner.show(in: view)
        
        guard let messageId = createMessageId(),
              let conversationId = conversationId,
              let sender = sender else {
            return
        }
        
        if let image = info[.editedImage] as? UIImage, let imageData = image.pngData() {
            
            let fileName = "photo_\(messageId).png".replacingOccurrences(of: " ", with: "")
            // Upload Image
            StorageManager.shared.uploadMessagePhoto(with: imageData,
                                                     fileName: fileName,
                                                     completion: { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let urlString):
                    // Ready to send message
                    print("Uploaded Message Photo:\(urlString)")
                    guard let url = URL(string: urlString),
                          let placeholder = UIImage(systemName: "photo") else {
                        return
                    }
                    
                    let media = Media(url: url,
                                      image: nil,
                                      placeholderImage: placeholder,
                                      size: .zero)
                    
                    let message = Message(sender: sender,
                                          messageId: messageId,
                                          sentDate: Date(),
                                          kind: .photo(media))
                    // Send Image Message
                    DatabaseManager.shared.sendMessage(conversationId: conversationId,
                                                       otherUser: self.otherUser,
                                                       newMessage: message,
                                                       completion: { success in
                        if success {
                            self.spinner.dismiss(animated: true)
                        } else {
                            self.displayAlert(message: "failed to send photo message")
                        }
                    })
                    
                case .failure(let error):
                    self.displayAlert(title: "Error", message: error.localizedDescription)
                }
            })
        }
        else if let videoUrl = info[.mediaURL] as? URL {
            let fileName = "video_\(messageId).mov".replacingOccurrences(of: " ", with: "")
            // Upload Video
            StorageManager.shared.uploadMessageVideo(with: videoUrl,
                                                     fileName: fileName,
                                                     completion: { [weak self] result in
                guard let self = self else {
                    return
                }
                switch result {
                case .success(let urlString):
                    // Ready to send message
                    print("Uploaded Message Video:\(urlString)")
                    guard let url = URL(string: urlString),
                          let placeholder = UIImage(systemName: "plus") else {
                        return
                    }
                    
                    let media = Media(url: url,
                                      image: nil,
                                      placeholderImage: placeholder,
                                      size: .zero)
                    
                    let message = Message(sender: sender,
                                          messageId: messageId,
                                          sentDate: Date(),
                                          kind: .video(media))
                    // Send Image Message
                    DatabaseManager.shared.sendMessage(conversationId: conversationId,
                                                       otherUser: self.otherUser,
                                                       newMessage: message,
                                                       completion: { success in
                        if success {
                            self.spinner.dismiss(animated: true)
                        } else {
                            self.displayAlert(message: "failed to send video message")
                        }
                    })
                    
                case .failure(let error):
                    self.displayAlert(title: "Error", message: error.localizedDescription)
                }
            })
        }
        
    }
    
}


// MARK: - MessageKit: - MessageCell Delegate

extension ChatViewController: MessageCellDelegate {
    
    func didTapMessage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        
        let message = messages[indexPath.section]
        switch message.kind {
        case .location(let locationData):
            let coordinate = locationData.location.coordinate
            let locationPickerVC = LocationPickerViewController(coordinate: coordinate)
            navigationController?.pushViewController(locationPickerVC, animated: true)
        default:
            break
        }
        
    }
    
    func didTapImage(in cell: MessageCollectionViewCell) {
        guard let indexPath = messagesCollectionView.indexPath(for: cell) else {
            return
        }
        
        let message = messages[indexPath.section]
        
        switch message.kind {
        case .photo(let media):
            guard let imageUrl = media.url else {
                return
            }
            let photoViewerVC = PhotoViewerViewController(url: imageUrl)
            photoViewerVC.modalPresentationStyle = .overCurrentContext // Disables that black background swift enables by default when presenting a view controller
            present(photoViewerVC, animated: true)
            
        case .video(let media):
            guard let videoUrl = media.url else {
                return
            }
            let playerVC = AVPlayerViewController()
            playerVC.player = AVPlayer(url: videoUrl)
            playerVC.player?.play()
            present(playerVC, animated: true)
            
        default:
            break
        }
    }
    
}
