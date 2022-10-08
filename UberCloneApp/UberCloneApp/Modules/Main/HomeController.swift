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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
//        signOut()
    }
    
    func configureUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
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
