//
//  NetworkHelper.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 28.03.2022.
//


import Alamofire

open class NetworkManager {

    open class func startNetworkReachabilityObserver() {
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.startListening(onUpdatePerforming: { status in
            switch status {
                case .reachable(.ethernetOrWiFi):
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HasInternetConnection"), object: nil)
                case .reachable(.cellular):
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "HasInternetConnection"), object: nil)
                case .notReachable:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NoInternetConnection"), object: nil)
                case .unknown :
                    print("It is unknown whether the network is reachable")
            }
        })
    }
}
