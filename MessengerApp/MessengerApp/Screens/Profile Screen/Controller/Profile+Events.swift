//
//  Profile+Events.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 01.03.2022.
//

import Foundation
import UIKit
import FirebaseAuth

extension ProfileViewController {
    
    @objc func profileTapAction() {
        displayPhotoActionSheet()
    }
    
    @objc func saveButtonAction() {
        if profileImageWasChanged {
            spinner.show(in: view)
            // upload image
            guard let image = self.profileHeaderView.profileImageView.image,
                  let data = image.pngData() else {
                return
            }
            
            guard let email = UserDefaults.standard.value(forKey: Constants.userEmail) as? String else {
                return
            }
            
            let fileName = email + "_profile_picture.png"
            
            StorageManager.shared.uploadProfilePicture(with: data, fileName: fileName, completion: { [weak self] results in
                switch results {
                case .success(let downloadUrl):
                   // UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                    self?.displayAlert(message: "Profile picture changed!")
                    self?.profileImageWasChanged = false
                    
                case .failure(let error):
                    self?.displayAlert(title: "Storage manager error", message: error.localizedDescription)
                }
                self?.spinner.dismiss(animated: true)
            })
        } else {
            displayAlert(title: ">_<", message: "It's the same profile picture.")
        }
    }
    
    @objc func logoutButtonAction() {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out",
                                            style: .destructive,
                                            handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                UserDefaults.standard.setValue(nil, forKey: Constants.userEmail)
                UserDefaults.standard.setValue(nil, forKey: Constants.fullName)
                
                let loginVC = LoginViewController()
                let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true)
            }
            catch {
                self.displayAlert(message: "Failed to log out..")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(actionSheet, animated: true)
    }
}
