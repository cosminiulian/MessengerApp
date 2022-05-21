//
//  Login+Events.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit
import FirebaseAuth

extension LoginViewController {
    
    @objc func loginButtonAction() {
        // Validation for email and password
        guard let email = loginView.emailTextField.text, let password = loginView.passwordTextField.text,
              email.isEmailValid(), password.isValid() else {
                  displayAlert(message: "Invalid Email or Password!")
                  return
              }
        
        spinner.show(in: view)
        
        // Firebase Log In
        print("Firebase Log In..")
        FirebaseAuth.Auth.auth().signIn(withEmail: loginView.emailTextField.text!,
                                        password: loginView.passwordTextField.text!,
                                        completion: { [weak self] authDataResult, error in
            
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                self.spinner.dismiss()
            }
            
            guard let result = authDataResult, error == nil else {
                self.displayAlert(message: error!.localizedDescription)
                return
            }
            
            let user = result.user
            
            DatabaseManager.shared.getUser(by: email, completion: { result in
                switch result {
                case .success(let user):
                    UserDefaults.standard.set(user.fullName, forKey: Constants.fullName)
               
                case .failure(let error):
                    self.displayAlert(message: error.localizedDescription)
                }
            })
            UserDefaults.standard.set(email, forKey: Constants.userEmail)
            print("Logged In User: \(user)")
            let tabBarController = TabBarController()
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true)
        })
        
    }
    
    @objc func createAccountButtonAction() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}
