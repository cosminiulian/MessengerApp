//
//  Conversation.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 07.03.2022.
//

struct Conversation {
    
    let id: String
    var isHidden: Bool
    let otherUserEmail: String
    let otherUserFullName: String
    var latestMessage: LatestMessage
}


struct LatestMessage {
    
    let content: String
    let date: String
    var isRead: Bool
}
