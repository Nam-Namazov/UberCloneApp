//
//  Trip.swift
//  UberCloneApp
//
//  Created by Намик on 10/11/22.
//

import CoreLocation

enum TripState: Int {
    case requested = 0
    case accepted
    case inProgress
    case completed
}

struct Trip {

    var pickupCoordinates: CLLocationCoordinate2D!
    var destinationCoordinates: CLLocationCoordinate2D!
    let passengerUid: String!
    var driverUid: String?
    var state: TripState!
    
    init(passengerUid: String, dictionary: [String: Any]) {
        self.passengerUid = passengerUid

        guard let pickupCoordinates = dictionary["pickupCoordinates"] as? NSArray,
              let lat = pickupCoordinates[0] as? CLLocationDegrees,
              let long = pickupCoordinates[1] as? CLLocationDegrees else {
            return
        }

        self.pickupCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        guard let destinationCoordinates = dictionary["destinationCoordinates"] as? NSArray,
              let lat = destinationCoordinates[0] as? CLLocationDegrees,
              let long = destinationCoordinates[1] as? CLLocationDegrees else {
            return
        }

        self.destinationCoordinates = CLLocationCoordinate2D(latitude: lat, longitude: long)

        driverUid = dictionary["driverUid"] as? String ?? ""
        
        if let state = dictionary["state"] as? Int {
            self.state = TripState(rawValue: state)
        }
    }
}

