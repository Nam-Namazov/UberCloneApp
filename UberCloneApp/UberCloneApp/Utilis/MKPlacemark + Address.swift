//
//  MKPlacemark + Address.swift
//  UberCloneApp
//
//  Created by Намик on 10/9/22.
//

import MapKit

extension MKPlacemark {
    var address: String? {
        get {
            guard let subThoroughfare = subThoroughfare,
                  let thoroughfare = thoroughfare,
                  let locality = locality,
                  let adminArea = administrativeArea else {
                return nil
            }

            return "\(subThoroughfare) \(thoroughfare), \(locality), \(adminArea)"
        }
    }
}
