//
//  Database+User.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 04.03.2022.
//

import Foundation

// Database operations for Users Collection
extension DatabaseManager {
    
    /// Check if user already exists for given email in Firestore database
    /// Parameters
    /// - `email`:               Target email to be checked
    /// - `completion`:    Async closure to return with result
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        let userId = IdGenerator.shared.generateUserId(email)
        
        usersCollection.document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
                completion(true)
            } else {
                print("Document does not exist")
                completion(false)
            }
        }
    }
    
    
    /// Inserts new user to Firestore database
    public func insert(user: User, completion: @escaping (Bool) -> Void) {
        let userDictionary: [String: Any] = [
            "full_name" : user.fullName,
            "email" : user.email
        ]
        let userId = IdGenerator.shared.generateUserId(user.email)
        
        usersCollection.document(userId).setData(userDictionary) { error in
            guard error == nil else {
                print("Error writing user: \(error!)")
                completion(false)
                return
            }
            
            completion(true)
        }
        
    }
    
    
    /// Get all users from Firestore database
    public func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        usersCollection.getDocuments() { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot, error == nil else {
                completion(.failure(error!))
                return
            }
            
            var users = [User]()
            for document in querySnapshot.documents {
                let user = User(fullName: document.data()["full_name"] as! String,
                                email: document.data()["email"] as! String)
                users.append(user)
            }
            completion(.success(users))
        }
    }
    
    
    /// Get  user by email from Firestore database
    public func getUser(by email: String, completion: @escaping ((Result<User, Error>) -> Void)) {
        let userId = IdGenerator.shared.generateUserId(email)
        
        usersCollection.document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                let user  = User(fullName: document.data()!["full_name"] as! String,
                                 email: document.data()!["email"] as! String)
                completion(.success(user))
            } else {
                print("Document does not exist")
                completion(.failure(DatabaseErrors.notFound))
            }
        }
        
    }
    
}
