//
//  AppDelegate+Network.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.03.2022.
//

//import UIKit
//
//extension AppDelegate {
//    
//    func startNetworkMonitoring() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.hasInternetConnection(notification:)), name: NSNotification.Name(rawValue: "HasInternetConnection"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.noInternetConnection(notification:)), name: NSNotification.Name(rawValue: "NoInternetConnection"), object: nil)
//        NetworkManager.startNetworkReachabilityObserver()
//    }
//    
//    func stopNetworkMonitoring() {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "HasInternetConnection"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "NoInternetConnection"), object: nil)
//    }
//    
//    @objc func hasInternetConnection(notification: NSNotification) {
//        print("internet connection")
//    }
//    
//    @objc func noInternetConnection(notification: NSNotification) {
//        displayNoInternetAlert()
//    }
//    
//}
