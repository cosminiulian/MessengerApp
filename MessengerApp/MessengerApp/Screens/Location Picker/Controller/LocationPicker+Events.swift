//
//  LocationPicker+Events.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 21.03.2022.
//

import UIKit
import MapKit

extension LocationPickerViewController {
    
    @objc func sendLocationAction() {
        guard let coordinate = locationCoordinate else {
            displayAlert(message: "No location selected!")
            return
        }
        completion?(coordinate)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func turnOnLocation() {
        if !locationWasEnabled {
            // Request authorization for location
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization() // For use in foreground
            // Check if location services are enabled or authorization status is different from being denied
            if CLLocationManager.locationServicesEnabled() && locationManager.authorizationStatus != .denied {
                // If authorization status is not determined yet then do nothing
                if locationManager.authorizationStatus != .notDetermined {
                    // display current location on the map
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.startUpdatingLocation()
                    mapView.isHidden = false
                    mapView.delegate = self
                    // update UI
                    title = "Current Location"
                    navigationItem.rightBarButtonItem?.image = UIImage(systemName: "location.fill")
                    sendButton.isHidden = false
                    // location has been activated, so you don't need to run this code again
                    locationWasEnabled = true
                }
            } else {
                // Display Location Alert and Change rightBarButton Image
                navigationItem.rightBarButtonItem?.image = UIImage(systemName: "location.slash.fill")
                displayLocationAlert()
            }
        }
    }
    
}
