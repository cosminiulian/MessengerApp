//
//  Database+Message.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 04.03.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import MessageKit
import CoreLocation

// Sending messages / conversations
extension DatabaseManager {
    
    /// Creates a new conversation with target user email and first message sent
    public func createNewConversation(with otherUser: User, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        
        guard let currentEmail = UserDefaults.standard.value(forKey: Constants.userEmail) as? String ,
              let currentFullName = UserDefaults.standard.value(forKey: Constants.fullName) as? String  else {
            return
        }
        // Generate first message id
        let firstMessageId = IdGenerator.shared.generateMessageId(senderEmail: currentEmail,
                                                                  otherUserEmail: otherUser.email,
                                                                  date: firstMessage.sentDate)
        // Generate conversation id
        let conversationId = IdGenerator.shared.generateConversationId(firstMessageId: firstMessageId)
        
        // OBS: First message it's just text message
        // Get content from message
        var messageContent = ""
        switch firstMessage.kind {
            
        case .text(let messageText):
            messageContent = messageText
            
        case .photo(_):
            break
        case .video(_):
            break
        case .location(_):
            break
        case .attributedText(_):
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
        
        let sentDateString = DateHelper.dateFormatter.string(from: firstMessage.sentDate)
        
        // Create dictionary
        let messageDictionary: [String: Any] = [
            "id": firstMessageId,
            "content": messageContent,
            "date": sentDateString,
            "kind": firstMessage.kind.stringValue,
            "sender_email": currentEmail,
            "other_user_email": otherUser.email
        ]
        
        // I made a change here
        conversationsCollection.document(conversationId)
            .collection("messages").document(firstMessageId).setData(messageDictionary) { error in
                guard error == nil else {
                    print("Error writing document: \(error!)")
                    completion(false)
                    return
                }
                
                // For current user in conversation
                finishCreatingConversation(currentEmail: currentEmail,
                                           otherUser: otherUser,
                                           conversationId: conversationId,
                                           messageContent: messageContent,
                                           currentDate: sentDateString,
                                           isRead: true,
                                           completion: { success in
                    if success {
                        // For other user in conversation
                        finishCreatingConversation(currentEmail: otherUser.email,
                                                   otherUser: User(fullName: currentFullName, email: currentEmail),
                                                   conversationId: conversationId,
                                                   messageContent: messageContent,
                                                   currentDate: sentDateString,
                                                   isRead: false,
                                                   completion: { success in
                            completion(success)
                        })
                        
                    } else {
                        completion(false)
                    }
                })
                
            }
        
    }
    
    
    public func finishCreatingConversation(currentEmail: String, otherUser: User, conversationId: String,
                                           messageContent: String, currentDate: String, isRead: Bool,
                                           completion: @escaping (Bool) -> Void) {
        // updates values
        let latestMessageDictionary: [String: Any] = [
            "content": messageContent,
            "date": currentDate,
            "is_read": isRead
        ]
        
        let conversationDictionary: [String: Any] = [
            "id": conversationId,
            "is_hidden": false,
            "other_user_email": otherUser.email,
            "other_user_full_name": otherUser.fullName,
            "latest_message": latestMessageDictionary
        ]
        
        let userId = IdGenerator.shared.generateUserId(currentEmail)
        
        usersCollection.document(userId)
            .collection("conversations").document(conversationId)
            .setData(conversationDictionary) { error in
                if let error = error {
                    print("Error writing new conversation in user: \(error)")
                    completion(false)
                } else {
                    print("Document successfully written!")
                    completion(true)
                }
            }
        
    }
    
    
    /// Fetches and returns all conversations for the user with passed in email
    public func getAllConversations(for email: String, completion: @escaping (Result<[Conversation], Error>) -> Void) {
        let userId = IdGenerator.shared.generateUserId(email)
        
        usersCollection.document(userId)
            .collection("conversations").addSnapshotListener { documentSnapshot, error in
                
                if let error = error {
                    print("Error getting documents: \(error)")
                    completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                    
                } else {
                    var conversationsArray: [Conversation] = []
                    for conversation in documentSnapshot!.documents {
                        let latestMessageData = conversation["latest_message"] as! [String: Any]
                        
                        let latestMessage = LatestMessage(content: latestMessageData["content"] as! String,
                                                          date: latestMessageData["date"] as! String,
                                                          isRead: latestMessageData["is_read"] as! Bool)
                        
                        let conversation = Conversation(id: conversation["id"] as! String,
                                                        isHidden: conversation["is_hidden"] as! Bool,
                                                        otherUserEmail: conversation["other_user_email"] as! String,
                                                        otherUserFullName: conversation["other_user_full_name"] as! String,
                                                        latestMessage: latestMessage)
                        
                        conversationsArray.append(conversation)
                    }
                    conversationsArray.sort {
                        let date1 = DateHelper.dateFormatter.date(from: $0.latestMessage.date)!
                        let date2 = DateHelper.dateFormatter.date(from: $1.latestMessage.date)!
                        return date1.compare(date2) == .orderedDescending
                    }
                    
                    completion(.success(conversationsArray))
                }
            }
        
    }
    
    
    /// Gets all messages for a given conversation
    public func getAllMessagesForConversation(with conversationId: String,
                                              completion: @escaping (Result<[Message], Error>) -> Void) {
        
        conversationsCollection.document(conversationId)
            .collection("messages").addSnapshotListener { documentSnapshot, error in
                
                guard let collection = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                var messagesArray: [Message] = []
                // MARK: - USE compactMap ({}) instead of for, looks cleaner
                for messageData in collection.documents {
                    let sender = Sender(senderId: messageData["sender_email"] as! String,
                                        displayName: messageData["other_user_email"] as! String,
                                        photoURL: "")
                    
                    let date = DateHelper.dateFormatter.date(from: messageData["date"] as! String)
                    let kind = messageData["kind"] as! String
                    let content  = messageData["content"] as! String
                    
                    var messageKind: MessageKind?
                    switch kind {
                    case "photo":
                        guard let imageUrl = URL(string: content),
                              let placeholder = UIImage(systemName: "plus") else {
                            return
                        }
                        let media = Media(url: imageUrl,
                                          image: nil,
                                          placeholderImage: placeholder,
                                          size: CGSize(width: 300, height: 300)) // temporally - we need size of the device
                        messageKind = .photo(media)
                        
                    case "video":
                        guard let videoUrl = URL(string: content),
                              let placeholder = UIImage(named: "VideoPlaceholder") else {
                            return
                        }
                        let media = Media(url: videoUrl,
                                          image: nil,
                                          placeholderImage: placeholder,
                                          size: CGSize(width: 300, height: 300)) // temporally - we need size of the device
                        messageKind = .video(media)
                        
                    case "location":
                        let locationComponents =  content.components(separatedBy: ",")
                        guard let longitude = Double(locationComponents[0]),
                              let latitude = Double(locationComponents[1]) else {
                            return
                        }
                        
                        let location = Location(location: CLLocation(latitude: latitude,
                                                                     longitude: longitude),
                                                size: CGSize(width: 300, height: 300))
                        messageKind = .location(location)
                        
                    default:
                        messageKind = .text(content)
                    }
                    
                    guard let finalMessageKind = messageKind else {
                        return
                    }
                    
                    let message = Message(sender: sender,
                                          messageId: messageData["id"] as! String,
                                          sentDate: date!,
                                          kind: finalMessageKind)
                    
                    messagesArray.append(message)
                }
                // sort array by sent date
                messagesArray.sort {
                    $0.sentDate.compare($1.sentDate) == .orderedAscending
                }
                print("NUMAR DE MESAJE:\(messagesArray.count)")
                completion(.success(messagesArray))
            }
    }
    
    
    /// Sends a message with target conversation and message
    public func sendMessage(conversationId: String, otherUser: User, newMessage: Message, completion: @escaping (Bool) -> Void) {
        
        var newMessageContent = ""
        switch newMessage.kind {
            
        case .text(let messageText):
            newMessageContent = messageText
            
        case .photo(let mediaItem):
            if let urlString = mediaItem.url?.absoluteString {
                newMessageContent = urlString
            }
            
        case .video(let mediaItem):
            if let urlString = mediaItem.url?.absoluteString {
                newMessageContent = urlString
            }
            
        case .location(let locationData):
            newMessageContent = "\(locationData.location.coordinate.longitude),\(locationData.location.coordinate.latitude)"
            
        case .attributedText(_):
            break
        case .emoji(_):
            break
        case .audio(_):
            break
        case .contact(_):
            break
        case .linkPreview(_):
            break
        case .custom(_):
            break
        }
        
        guard let currentUserEmail = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            completion(false)
            return
        }
        
        let sentDateString = DateHelper.dateFormatter.string(from: newMessage.sentDate)
        let messageId = IdGenerator.shared.generateMessageId(senderEmail: currentUserEmail,
                                                             otherUserEmail: otherUser.email)
        
        let newMessageDictionary: [String: Any] = [
            "content": newMessageContent,
            "date": sentDateString,
            "id": messageId,
            "kind": newMessage.kind.stringValue,
            "other_user_email": otherUser.email,
            "sender_email": currentUserEmail,
        ]
        
        // Insert new message to messages collection
        conversationsCollection.document(conversationId)
            .collection("messages").document(newMessage.messageId).setData(newMessageDictionary) { error in
                guard error == nil else {
                    print("Error writing user: \(error!)")
                    completion(false)
                    return
                }
                completion(true)
            }
        
        // Update latest message on both users
        let userLatestMessageDictionary: [String: Any] = [
            "content": newMessageContent,
            "date": sentDateString,
            "is_read": true
        ]
        let otherUserLatestMessageDictionary: [String: Any] = [
            "content": newMessageContent,
            "date": sentDateString,
            "is_read": false
        ]
        
        let currentUserId = IdGenerator.shared.generateUserId(currentUserEmail)
        // update sender latest message
        usersCollection.document(currentUserId)
            .collection("conversations").document(conversationId).updateData(["latest_message": userLatestMessageDictionary])
        
        let otherUserId = IdGenerator.shared.generateUserId(otherUser.email)
        // update other user latest message or create conversation again for that user if doesn't exists
        usersCollection.document(otherUserId)
            .collection("conversations").document(conversationId).updateData(["latest_message": otherUserLatestMessageDictionary])
    }
    
    
    /// Hide a conversation by id from Firestore Database
    public func hideConversation(conversation: Conversation, completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            return
        }
        
        let userId = IdGenerator.shared.generateUserId(email)
        usersCollection.document(userId).collection("conversations").document(conversation.id).updateData([
            "is_hidden": true,
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    /// Unhide a conversation by id from Firestore Database
    public func unhideConversation(conversation: Conversation, completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            return
        }
        
        let userId = IdGenerator.shared.generateUserId(email)
        usersCollection.document(userId).collection("conversations").document(conversation.id).updateData([
            "is_hidden": false,
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
    /// Read a conversation by id from Firestore Database
    public func readConversation(conversation: Conversation, completion: @escaping (Bool) -> Void) {
        guard let email = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
            return
        }
        
        // MARK: - needs to be optimezed
        let latestMessageDictionary: [String: Any] = [
            "content": conversation.latestMessage.content,
            "date": conversation.latestMessage.date,
            "is_read": true
            
        ]
        
        let userId = IdGenerator.shared.generateUserId(email)
        usersCollection.document(userId).collection("conversations").document(conversation.id).updateData(
            ["latest_message": latestMessageDictionary]
        ) { error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }
    
}
