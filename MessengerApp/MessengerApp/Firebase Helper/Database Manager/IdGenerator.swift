//
//  IdGenerator.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 11.03.2022.
//

import Foundation

struct IdGenerator {
    
    static let shared = IdGenerator()
    
    private init() { }
    
    public func generateUserId(_ email: String) -> String {
        return "user_\(email)"
    }
    
    public func generateConversationId(firstMessageId: String) -> String {
        return "conversation_\(firstMessageId)"
    }
    
    public func generateMessageId(senderEmail: String, otherUserEmail: String, date: Date? = nil) -> String {
        let currentDateString = DateHelper.dateFormatter.string(from: date ?? Date())
        return "message_\(senderEmail)_with_\(otherUserEmail)_at_\(currentDateString)"
    }
    
}
