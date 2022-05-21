//
//  MessageKind+Extension.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 07.03.2022.
//

import MessageKit

extension MessageKind {
    var stringValue: String {
        
        switch self {
        case .text(_):
            return "text"
            
        case .attributedText(_):
            return "attributed_text"
            
        case .photo(_):
            return "photo"
            
        case .video(_):
            return "video"
            
        case .location(_):
            return "location"
            
        case .emoji(_):
            return "emoji"
            
        case .audio(_):
            return "audio"
            
        case .contact(_):
            return "contact"
            
        case .linkPreview(_):
            return "linkPreview"
            
        case .custom(_):
            return "custom"
        }
    }
    
}
