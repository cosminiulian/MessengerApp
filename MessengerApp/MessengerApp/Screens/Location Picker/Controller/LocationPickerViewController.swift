//
//  LocationPickerViewController.swift
//  MessengerApp
//
//  Created by Cosmin Iulian on 15.03.2022.
//

import UIKit
import MapKit
import CoreLocation

class LocationPickerViewController: UIViewController {
    
    public var completion: ((CLLocationCoordinate2D) -> (Void))?
    
    let isSendable: Bool!
    var locationWasEnabled = false
    
    var locationCoordinate: CLLocationCoordinate2D?
    let locationManager = CLLocationManager()
   
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isHidden = true
        return mapView
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font =  .boldSystemFont(ofSize: 18)
        button.setTitle("Send Location", for: .normal)
        button.setTitleColor(.tertiarySystemBackground, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 10
        button.isHidden = true
        return button
    }()
    
    init() {
        isSendable = true
        super.init(nibName: nil, bundle: nil)
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        isSendable = false
        locationCoordinate = coordinate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        setupNavController()
        setupSubviews()
        setupConstraints()
        setupButtonsMethods()
        setupMap()
    }
    
}
