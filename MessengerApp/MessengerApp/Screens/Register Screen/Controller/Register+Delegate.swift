//
//  Register+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.02.2022.
//

import UIKit

extension RegisterViewController: UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case registerView.fullNameTextField:
            registerView.emailTextField.becomeFirstResponder()
            
        case registerView.emailTextField:
            registerView.passwordTextField.becomeFirstResponder()
            
        case registerView.passwordTextField:
            registerView.confirmPasswordTextField.becomeFirstResponder()
            
        case registerView.confirmPasswordTextField:
            registerButtonAction()
            
        default:
            break
        }
        
        return true
    }
    
    // ImagePickerController Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        
        registerView.profileImageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
