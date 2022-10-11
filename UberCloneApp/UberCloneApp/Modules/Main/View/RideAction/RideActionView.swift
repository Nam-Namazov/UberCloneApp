//
//  RideActionView.swift
//  UberCloneApp
//
//  Created by Намик on 10/11/22.
//

import UIKit
import MapKit

protocol RideActionViewDelegate: AnyObject {
    func uploadTrip(_ view: RideActionView)
}

class RideActionView: UIView {

    enum Configuration {
        case requestRide
        case tripAccepted
        case pickupPassenger
        case tripIntProgress
        case endTrip

        init() {
            self = .requestRide
        }
    }

    weak var delegate: RideActionViewDelegate?

    private var config = Configuration()
    private var buttonAction = ButtonAction()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private let addressLabel: UILabel = {
        let addressLabel = UILabel()
        addressLabel.textColor = .lightGray
        addressLabel.font = .systemFont(ofSize: 16)
        addressLabel.textAlignment = .center
        addressLabel.numberOfLines = 1
        addressLabel.lineBreakMode = .byTruncatingTail
        addressLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30).isActive = true
        return addressLabel
    }()

    private let infoView: UIView = {
        let infoView = UIView()
        infoView.backgroundColor = .black
        infoView.setDimensions(height: 60, width: 60)
        infoView.layer.cornerRadius = 60/2

        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        label.text = "X"

        infoView.addSubview(label)
        label.centerX(inView: infoView)
        label.centerY(inView: infoView)

        return infoView
    }()

    private let uberXLabel: UILabel = {
        let uberXLabel = UILabel()
        uberXLabel.font = .systemFont(ofSize: 18)
        uberXLabel.text = "UberX"
        uberXLabel.textAlignment = .center
        return uberXLabel
    }()

    private lazy var actionButton: UIButton = {
        let actionButton = UIButton(type: .system)
        actionButton.backgroundColor = .black
        actionButton.setTitle("CONFIRM UBERX", for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        actionButton.addTarget(self, action: #selector(onRide), for: .touchUpInside)
        return actionButton
    }()

    var destination: MKPlacemark? {
        didSet {
            titleLabel.text = destination?.name
            addressLabel.text = destination?.address
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }

    func setup(withConfig: Configuration) {
        switch config {
        case .requestRide:
            buttonAction = .requestRide
            actionButton.setTitle(buttonAction.description, for: .normal)
        case .tripAccepted:
            titleLabel.text = "On Route To Passsenger"
            buttonAction = .getDirections
            actionButton.setTitle(buttonAction.description, for: .normal)
        case .pickupPassenger:
            fallthrough
        case .tripIntProgress:
            fallthrough
        case .endTrip:
            break
        }
    }

    private func style() {
        backgroundColor = .white
        addShadow()
    }
    
    private func layout() {
        let stack = UIStackView(arrangedSubviews: [titleLabel, addressLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .fillEqually
        
        addSubview(stack)
        stack.centerX(inView: self)
        stack.anchor(top: topAnchor, paddingTop: 12)
        
        addSubview(infoView)
        infoView.centerX(inView: self)
        infoView.anchor(top: stack.bottomAnchor, paddingTop: 16)
        
        addSubview(uberXLabel)
        uberXLabel.anchor(top: infoView.bottomAnchor, paddingTop: 8)
        uberXLabel.centerX(inView: self)
        
        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray
        addSubview(separatorView)
        separatorView.anchor(top: uberXLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 4, height: 0.75)
        
        addSubview(actionButton)
        actionButton.anchor(left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingLeft: 12, paddingBottom: 12, paddingRight: 12, height: 50)
    }

    @objc private func onRide() {
        delegate?.uploadTrip(self)
    }
}
