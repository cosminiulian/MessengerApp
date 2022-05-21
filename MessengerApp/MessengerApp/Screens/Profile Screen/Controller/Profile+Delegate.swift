//
//  Profile+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 29.03.2022.
//

import UIKit

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // ImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        
        profileHeaderView.profileImageView.image = selectedImage
        profileImageWasChanged = true
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
