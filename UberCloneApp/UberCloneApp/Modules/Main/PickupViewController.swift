//
//  PickupViewController.swift
//  UberCloneApp
//
//  Created by Намик on 10/11/22.
//

import UIKit
import MapKit

protocol PickupVCDelegate: AnyObject {
    func didAcceptTrip(_ trip: Trip)
}

final class PickupViewController: UIViewController {

    weak var delegate: PickupVCDelegate?

    private lazy var circularProgressView: CircularProgressView = {
        let frame = CGRect(x: 0, y: 0, width: 360, height: 360)
        let cp = CircularProgressView(frame: frame)
        
        cp.addSubview(mapView)
        mapView.setDimensions(height: 268, width: 268)
        mapView.layer.cornerRadius = 268 / 2
        mapView.centerX(inView: cp)
        mapView.centerY(inView: cp, constant: 32)
        
        return cp
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.setDimensions(height: 270, width: 270)
        mapView.layer.cornerRadius = 270 / 2
        return mapView
    }()
    
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .system)
        cancelButton.setImage(UIImage(named: "baseline_clear_white_36pt_2x")?.withRenderingMode(.alwaysOriginal), for: .normal)
        cancelButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return cancelButton
    }()
    
    private let pickupLabel: UILabel = {
        let pickupLabel = UILabel()
        pickupLabel.text = "Would you like to pickup this passenger?"
        pickupLabel.font = .systemFont(ofSize: 16)
        pickupLabel.textColor = .white
        return pickupLabel
    }()
    
    private lazy var acceptTripButton: UIButton = {
        let acceptTripButton = UIButton(type: .system)
        acceptTripButton.addTarget(self, action: #selector(handleAcceptTrip), for: .touchUpInside)
        acceptTripButton.backgroundColor = .white
        acceptTripButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        acceptTripButton.setTitleColor(.black, for: .normal)
        acceptTripButton.setTitle("ACCEPT TRIP", for: .normal)
        return acceptTripButton
    }()
    
    override var prefersStatusBarHidden: Bool {
        true
    }

    private let trip: Trip

    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(animateProgress), with: nil, afterDelay: 0.5)
        setup()
        layout()
        style()
    }
    
    init(trip: Trip) {
        self.trip = trip
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    private func setup() {
        let region = MKCoordinateRegion(center: trip.pickupCoordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: false)
        
        let anno = MKPointAnnotation()
        anno.coordinate = trip.pickupCoordinates
        mapView.addAnnotation(anno)
        mapView.selectAnnotation(anno, animated: true)
    }
    
    private func layout() {
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingLeft: 16)
        
        view.addSubview(circularProgressView)
        circularProgressView.setDimensions(height: 360, width: 360)
        circularProgressView.centerX(inView: view)
        circularProgressView.centerY(inView: view, constant: -182)
        
        view.addSubview(mapView)
        mapView.centerX(inView: view)
        mapView.centerY(inView: view, constant: -150)
        
        view.addSubview(pickupLabel)
        pickupLabel.centerX(inView: view)
        pickupLabel.anchor(top: mapView.bottomAnchor, paddingTop: 60)
        
        view.addSubview(acceptTripButton)
        acceptTripButton.anchor(
            top: pickupLabel.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 16,
            paddingLeft: 32,
            paddingRight: 32,
            height: 50
        )
    }

    private func style() {
        view.backgroundColor = .backgroundColor
    }

    @objc private func handleDismissal() {
        dismiss(animated: true)
    }

    @objc private func animateProgress() {
        circularProgressView.animatePulsatingLayer()
        circularProgressView.setProgressWithAnimation(duration: 10, value: 0)
    }

    @objc private func handleAcceptTrip() {
        FirebaseService.shared.acceptTrip(trip: trip) { error, ref in
            self.delegate?.didAcceptTrip(self.trip)
        }
    }
}
