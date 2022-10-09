//
//  LocationHandler.swift
//  UberCloneApp
//
//  Created by Намик on 10/9/22.
//

import CoreLocation

final class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()

    private var location: CLLocation?
    var locationManager: CLLocationManager!
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

