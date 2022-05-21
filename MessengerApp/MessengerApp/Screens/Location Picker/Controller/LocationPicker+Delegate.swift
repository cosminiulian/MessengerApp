//
//  LocationPicker+Delegate.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 06.04.2022.
//

import MapKit
import CoreLocation

extension LocationPickerViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            // remove all annotations before adding the pin
            mapView.removeAnnotations(mapView.annotations)
            // update value of coordinate variable
            locationCoordinate = location.coordinate
            // drop a pin on that location
            let pin = MKPointAnnotation()
            pin.coordinate = locationCoordinate!
            mapView.addAnnotation(pin)
        }
    }
    
}
