//
//  User.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.02.2022.
//

struct User {
    
    let fullName: String
    let email: String
    
    func getProfilePictureFileName() -> String {
        return "\(email)_profile_picture.png"
    }
}
