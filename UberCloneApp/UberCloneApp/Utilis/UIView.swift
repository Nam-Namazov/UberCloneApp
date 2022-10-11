//
//  UIView.swift
//  UberCloneApp
//
//  Created by Намик on 10/8/22.
//

import UIKit

extension UIView {
    static func makeInputContainerView(image: UIImage,
                                       textField: UITextField? = nil,
                                       segmentedControl: UISegmentedControl? = nil) -> UIView {
        let inputContainerView = UIView()
        let imageView = UIImageView()
        imageView.image = image
        imageView.alpha = 0.87

        inputContainerView.addSubview(imageView)
        if let textField = textField {
            imageView.centerY(inView: inputContainerView)
            imageView.anchor(left: inputContainerView.leftAnchor,
                             paddingLeft: 8,
                             width: 24,
                             height: 24)

            inputContainerView.addSubview(textField)
            textField.centerY(inView: inputContainerView)
            textField.anchor(
                left: imageView.rightAnchor,
                bottom: inputContainerView.bottomAnchor,
                right: inputContainerView.rightAnchor,
                paddingLeft: 8,
                paddingBottom: 8
            )
        }

        if let segmentedControl = segmentedControl {
            imageView.anchor(top: inputContainerView.topAnchor,
                             left: inputContainerView.leftAnchor,
                             paddingLeft: 8,
                             width: 24,
                             height: 24)
            inputContainerView.addSubview(segmentedControl)
            segmentedControl.anchor(left: inputContainerView.leftAnchor,
                                    right: inputContainerView.rightAnchor,
                                    paddingLeft: 8,
                                    paddingRight: 8)
            segmentedControl.centerY(inView: inputContainerView, constant: 8)

        }

        let separatorView = UIView()
        separatorView.backgroundColor = .lightGray

        inputContainerView.addSubview(separatorView)
        separatorView.anchor(
            left: inputContainerView.leftAnchor,
            bottom: inputContainerView.bottomAnchor,
            right: inputContainerView.rightAnchor,
            paddingLeft: 8,
            height: 0.75
        )

        return inputContainerView
    }

    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.55
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
    }
}
