//
//  Register+Events.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import FirebaseAuth

extension RegisterViewController {
    
    @objc func profileTapAction() {
        displayPhotoActionSheet()
    }
    
    @objc func registerButtonAction() {
        // Validations
        guard let fullName = registerView.fullNameTextField.text,
              let email = registerView.emailTextField.text,
              let password = registerView.passwordTextField.text,
              let confirmPassword = registerView.confirmPasswordTextField.text,
              fullName.isFullNameValid(), email.isEmailValid(),
              password.isValid(), confirmPassword.isValid() else {
            
            displayAlert(message: "Invalid data!")
            return
        }
        
        if password != confirmPassword {
            displayAlert(message: "Passwords don't match!")
            return
        }
        
        spinner.show(in: view)
        
        // Firebase register
        
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.spinner.dismiss()
            }
            
            guard !exists else {
                self.displayAlert(message: "Email already exists!")
                return
            }
            
            // Firebase Auth
            
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authDataResult, error in
                
                guard authDataResult != nil, error == nil else {
                    self.displayAlert(title: "Error creating user", message: error?.localizedDescription)
                    return
                }
                
                let user = User(fullName: fullName, email: email)
                // Insert user into database
                DatabaseManager.shared.insert(user: user, completion: { success in
                    if success {
                        // upload image
                        guard let image = self.registerView.profileImageView.image,
                              let data = image.pngData() else {
                            return
                        }
                        let fileName = user.getProfilePictureFileName()
                        StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName, completion: { results in
                            switch results {
                            case .success(let downloadUrl):
                                print("uncomment this if doesn't work")
                                //UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                                
                            case .failure(let error):
                                self.displayAlert(title: "Storage manager error", message: error.localizedDescription)
                            }
                        })
                    }
                })
                self.displayAlertWithPopVC(message: "Account successfully created!")
            })
            
        })
        
    }
    
}
