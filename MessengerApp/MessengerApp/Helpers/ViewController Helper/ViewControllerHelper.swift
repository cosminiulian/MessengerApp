//
//  ViewControllerHelper.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 26.02.2022.
//

import UIKit

extension UIViewController {
    
    func displayAlert(title: String? = "", message: String? = "") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel))
        present(alert, animated: true)
    }
    
    func displayAlertWithPopVC(title: String? = "", message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    func displayLocationAlert() {
        let alert = UIAlertController(title: "Location Services",
                                      message: "Enable location services from Settings to identify your current location directly",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))
        alert.addAction(UIAlertAction(title: "Settings",
                                      style: .default,
                                      handler: { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }))
        present(alert, animated: true)
    }
    
}
