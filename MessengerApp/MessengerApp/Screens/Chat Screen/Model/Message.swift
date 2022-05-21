//
//  Message.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 07.03.2022.
//

import MessageKit

struct Message: MessageType {
    
    public var sender: SenderType
    public var messageId: String
    public var sentDate: Date
    public var kind: MessageKind
}
