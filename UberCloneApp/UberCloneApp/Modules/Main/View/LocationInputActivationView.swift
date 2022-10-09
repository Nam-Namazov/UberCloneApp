//
//  LocationInputActivationView.swift
//  UberCloneApp
//
//  Created by Намик on 10/9/22.
//

import UIKit

protocol LocationInputActivationViewDelegate: AnyObject {
    func presentLocationInputView()
}

final class LocationInputActivationView: UIView {

    weak var delegate: LocationInputActivationViewDelegate?

    private let indicatorView: UIView = {
        let indicatorView = UIView()
        indicatorView.backgroundColor = .black
        indicatorView.setDimensions(height: 6, width: 6)
        return indicatorView
    }()

    private let placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Where to?"
        placeholderLabel.font = .systemFont(ofSize: 18)
        placeholderLabel.textColor = .darkGray
        return placeholderLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        tapGesture()
        layout()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented. No storyboards")
    }


    private func layout() {
        addSubview(indicatorView)
        indicatorView.centerY(inView: self,
                              leftAnchor: leftAnchor,
                              paddingLeft: 16)
        
        addSubview(placeholderLabel)
        placeholderLabel.centerY(inView: self,
                                 leftAnchor: indicatorView.rightAnchor,
                                 paddingLeft: 20)
    }

    private func style() {
        backgroundColor = .white
        addShadow()
    }
    
    private func tapGesture() {
        let inputLocationTap = UITapGestureRecognizer(
            target: self,
            action: #selector(presentLocationInputView)
        )
        addGestureRecognizer(inputLocationTap)
    }

    @objc
    private func presentLocationInputView() {
        delegate?.presentLocationInputView()
    }
}
