//
//  HomeController.swift
//  UberCloneApp
//
//  Created by Намик on 10/8/22.
//

import UIKit
import Firebase
import MapKit

final class HomeController: UIViewController {
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let inputActivationView = LocationInputActivationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        enableLocationServices()
//        signOut()
    }
    
    func configureUI() {
        configureMapView()
        configureInputActivationView()
    }
    
    private func configureInputActivationView() {
        view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimensions(height: 50,
                                          width: view.frame.width - 64)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                   paddingTop: 32)
        inputActivationView.delegate = self
        inputActivationView.alpha = 0
        UIView.animate(withDuration: 2) {
            self.inputActivationView.alpha = 1
        }
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    private func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let navLogin = UINavigationController(rootViewController: LoginController())
                navLogin.modalPresentationStyle = .fullScreen
                self.present(navLogin, animated: false)
            }
        } else {
            configureUI()
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                let navLogin = UINavigationController(rootViewController: LoginController())
                navLogin.modalPresentationStyle = .fullScreen
                self.present(navLogin, animated: true, completion: nil)
            }
        } catch {
            print("DEBUG: Error signing out")
        }
    }
}

// MARK: - LocationServices
extension HomeController: CLLocationManagerDelegate {
    
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("auth always")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("auth when in use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

// MARK: - LocationInputActivationViewDelegate
extension HomeController: LocationInputActivationViewDelegate {
    func presentLocationInputView() {
        print("delegate")
    }
}
