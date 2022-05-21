//
//  DatabaseManager.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.02.2022.
//

import FirebaseFirestore

/// Manager struct  to read and write data to real time firebase database
struct DatabaseManager {
    
    let usersCollection = Firestore.firestore().collection("users")
    let conversationsCollection = Firestore.firestore().collection("conversations")
    
    // Shared instance of struct
    static let shared = DatabaseManager()
    
    private init() { }
    
}
