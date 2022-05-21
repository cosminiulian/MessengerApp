//
//  LocationPicker+Design.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 21.03.2022.
//

import UIKit
import MapKit
import CoreLocation

extension LocationPickerViewController: DesignProtocol {
    
    func setupNavController() {
        if isSendable {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "location.fill"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(turnOnLocation))
        }
    }
    
    func setupSubviews() {
        mapView.addSubview(sendButton)
        view.addSubview(mapView)
    }
    
    func setupConstraints() {
        mapView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       left: view.leftAnchor,
                       bottom: view.safeAreaLayoutGuide.bottomAnchor,
                       right: view.rightAnchor)
        
        sendButton.anchor(left: mapView.leftAnchor,
                          bottom: mapView.bottomAnchor,
                          right: mapView.rightAnchor,
                          leftConstant: 20,
                          bottomConstant: 20,
                          rightConstant: 20,
                          heightConstant: 60)
    }
    
    func setupButtonsMethods() {
        sendButton.addTarget(self, action: #selector(sendLocationAction), for: .touchUpInside)
    }
    
    func setupMap() {
        if isSendable {
         // send current location
            turnOnLocation()
        } else {
            // just showing Location
            title = "Location"
            guard let coordinate = locationCoordinate else { return }
            let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.isHidden = false
            mapView.setRegion(region, animated: true)
            // drop a pin on that Location
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            mapView.addAnnotation(pin)
        }
    }
    
}
