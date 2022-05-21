//
//  Login+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.02.2022.
//

import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.emailTextField {
            loginView.passwordTextField.becomeFirstResponder()
        }
        else if textField == loginView.passwordTextField {
            loginButtonAction()
        }
        
        return true
    }
    
}
